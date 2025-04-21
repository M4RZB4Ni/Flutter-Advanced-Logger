import 'package:log_engine/src/core/log_priority.dart';

/// An interface for remote logging implementations.
abstract interface class IRemoteLogger {
  /// Logs a message with the specified priority.
  ///
  /// The [priority] indicates the severity of the log message.
  /// The [message] is the content of the log.
  /// Optional [tag] can be used to categorize logs.
  /// Optional [error] can be attached to the log message for error reporting.
  void log(LogPriority priority, String message, {String? tag, Object? error});
}
