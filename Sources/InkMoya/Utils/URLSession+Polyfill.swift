import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public extension URLSession {
    
    func ink_data(for request: URLRequest) async throws -> (Data, URLResponse) {
        #if canImport(Darwin)
        if #available(macOS 12.0, iOS 15.0, tvOS 13.0, watchOS 8.0, *) {
            return try await self.data(for: request)
        }
        #endif
        
        var task: URLSessionDataTask?
        let canceller = { task?.cancel() }
        
        return try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { continuation in
                task = self.dataTask(with: request) { data, response, error in
                    guard let data = data, let response = response else {
                        return continuation.resume(throwing: error ?? URLError(.badServerResponse))
                    }
                    continuation.resume(returning: (data, response))
                }
                task?.resume()
            }
        } onCancel: {
            canceller()
        }
    }
}
