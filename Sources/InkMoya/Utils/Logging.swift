import Logging

private var _logger = Logger(label: "app.imink.InkMoya")

var logger: Logger {
    _logger.logLevel = InkMoya.logLevel
    return _logger
}