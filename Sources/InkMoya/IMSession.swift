import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public protocol IMSessionType {
    func request(api targetType: TargetType) async throws -> (Data, URLResponse)
}

public struct IMSession: IMSessionType {
    public static var shared: IMSession = IMSession(urlSession: URLSession.shared)

    private let urlSession: URLSession
    public var plugins: [PluginType] = []

    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    public func request(api targetType: TargetType) async throws -> (Data, URLResponse) {
        var request = targetType.request
        
        request = plugins.reduce(request) { $1.prepare($0, target: targetType) }

        logger.trace("---- Request ----")
        logger.trace("Path: \(request.url?.absoluteString ?? "")")
        logger.trace("Headers: \(String(describing: request.allHTTPHeaderFields))")
        if let httpBody = request.httpBody {
            logger.trace("Body: \(String(data: httpBody, encoding: .utf8)!)")
        }

        let (data, res) = try await urlSession.data(for: request)

        logger.trace("---- Response ----")
        logger.trace("Json: \(String(data: data, encoding: .utf8)!) \n\n")

        return (data, res)
    }
}
