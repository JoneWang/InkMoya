import Foundation
import Logging

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public class LoggerPlugin: PluginType {
    
    public let logger: Logger
    
    public init(logger: Logger) {
        self.logger = logger
    }
    
    public func willSend(_ request: URLRequest, target: TargetType) {
        logger.trace("---- Request ----")
        logger.trace("Path: \(request.url?.absoluteString ?? "")")
        logger.trace("Headers: \(String(describing: request.allHTTPHeaderFields))")
        if let httpBody = request.httpBody {
            if httpBody.count < 1000, let str = String(data: httpBody, encoding: .utf8) {
                logger.trace("Body: \(str)")
            } else {
                logger.trace("\(httpBody.count) byte \n\n")
            }
        }
    }
    
    public func didReceive(_ result: Result<(Data, HTTPURLResponse), Error>, target: TargetType) {
        logger.trace("---- Response ----")
        switch result {
        case let .success((_, resp)):
            logger.trace("ContentLength: \(resp.expectedContentLength)")
        case let .failure(error):
            logger.trace("Error: \(error) \n\n")
        }
        
    }
}
