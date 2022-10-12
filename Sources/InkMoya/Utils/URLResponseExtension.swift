import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public extension URLResponse {
    var httpURLResponse: HTTPURLResponse {
        self as! HTTPURLResponse
    }
}
