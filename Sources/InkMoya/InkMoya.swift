import Logging

public typealias LogLevel = Logger.Level

public struct InkMoya {
    static var logLevel = LogLevel.error

    public static func setLogLevel(_ logLevel: LogLevel) {
        InkMoya.logLevel = logLevel
    }
}