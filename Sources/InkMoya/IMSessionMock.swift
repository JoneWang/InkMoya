import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public class IMSessionMock: IMSessionType {
    public var plugins: [PluginType] = []

    public func request(api target: TargetType) async throws -> (Data, HTTPURLResponse) {
        let request = plugins.reduce(target.request) { $1.prepare($0, target: target) }
        plugins.forEach { $0.willSend(request, target: target) }
        let data = target.sampleData
        let resp = HTTPURLResponse(url: target.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        plugins.forEach { $0.didReceive(.success((data, resp)), target: target) }
        return (data, resp)
    }
}
