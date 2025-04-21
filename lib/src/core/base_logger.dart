import 'package:log_engine/src/core/log_priority.dart';

/// Logger interface defining log functions with priority levels
abstract class BaseLogger {
  /// Logs a message with the given [priority].
  ///
  /// Optionally, you can provide a [tag] to categorize the log message.
  /// If an [error] occurs, you can provide it for detailed logging.
  void log(LogPriority priority, String message, {String? tag, Object? error});

  /// Logs a warning message.
  ///
  /// [message] is the warning message to be logged.
  /// Optionally, you can provide a [tag] for filtering.
  void warn(String message, {String? tag});

  /// Logs an error message.
  ///
  /// [message] is the error message to be logged.
  /// Optionally, you can provide an [error] object for more details.
  /// You can also add a [tag] to the error log.
  void error(String message, {Object? error, String? tag});

  /// Logs a debug message.
  ///
  /// [message] is the debug message to be logged.
  /// Optionally, you can provide a [tag] for filtering.
  void debug(String message, {String? tag});

  /// Logs an informational message.
  ///
  /// [message] is the information message to be logged.
  /// Optionally, you can provide a [tag] for filtering.
  void info(String message, {String? tag});
}
