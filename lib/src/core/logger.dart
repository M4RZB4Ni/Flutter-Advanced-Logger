import 'package:log_engine/src/core/environment_provider.dart';
import 'package:log_engine/src/core/log_priority.dart';
import 'package:log_engine/src/core/logger_provider.dart';
import 'package:log_engine/src/remote_logger/remote_logger_interface.dart';

/// A utility class for logging messages with different priorities.
class Logger {
  /// Initializes the Logger with the provided [environmentProvider] and optional [remoteLogger].
  ///
  /// This factory constructor sets up the logging environment and configures an optional remote logger.
  /// It returns the singleton instance of the Logger.
  factory Logger(EnvironmentProvider environmentProvider, {IRemoteLogger? remoteLogger}) {
    _environmentProvider = environmentProvider;
    _remoteLogger = remoteLogger;
    return _instance;
  }

  /// Private internal constructor to set up the [LoggerProvider].
  Logger._internal() {
    LoggerProvider.initialize(
      _environmentProvider,
      remoteLogger: _remoteLogger,
    );
  }

  /// The singleton instance of the Logger.
  static final Logger _instance = Logger._internal();

  /// The provider for the environment configuration.
  static late EnvironmentProvider _environmentProvider;

  /// The optional remote logger instance.
  static late IRemoteLogger? _remoteLogger;

  /// Logs a message with the specified [priority].
  ///
  /// The [message] is the content of the log.
  /// The [tag] is an optional identifier for the log.
  /// The [error] is an optional error object associated with the log.
  ///
  /// Example:
  ///
  static void log(LogPriority priority, String message, {String? tag, Object? error}) {
    LoggerProvider.logger.log(priority, message, tag: tag, error: error);
  }

  static void warn(String message, {String? tag}) {
    LoggerProvider.logger.warn(message, tag: tag);
  }

  static void error(String message, {Object? error, String? tag}) {
    LoggerProvider.logger.error(message, error: error, tag: tag);
  }

  static void debug(String message, {String? tag}) {
    LoggerProvider.logger.debug(message, tag: tag);
  }

  static void info(String message, {String? tag}) {
    LoggerProvider.logger.info(message, tag: tag);
  }
}
