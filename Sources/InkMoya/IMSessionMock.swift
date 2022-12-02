import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public class IMSessionMock: IMSessionType {
    public var plugins: [PluginType] = []

    public func request(api targetType: TargetType) async throws -> (Data, URLResponse) {
        var request = targetType.request

        request = plugins.reduce(request) { $1.prepare($0, target: targetType) }
        
        logger.trace("---- Request ----")
        logger.trace("Path: \(request.url?.absoluteString ?? "")")
        logger.trace("Headers: \(String(describing: request.allHTTPHeaderFields))")
        let response = HTTPURLResponse(url: targetType.url, statusCode: 200, httpVersion: nil, headerFields: nil)
        logger.trace("---- Response ----")
        logger.trace("Json: \(String(data: targetType.sampleData, encoding: .utf8)!) \n\n")

        return (targetType.sampleData, response!)
    }

    public func request(_ request: URLRequest) async throws -> (Data, URLResponse) {
        logger.trace("---- Request ----")
        logger.trace("Path: \(request.url?.absoluteString ?? "")")
        logger.trace("Headers: \(String(describing: request.allHTTPHeaderFields))")
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        logger.trace("---- Response ----")

        return ("".data(using: .utf8)!, response!)
    }
}
