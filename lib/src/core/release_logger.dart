import 'dart:developer' as developer;

import 'package:log_engine/src/core/base_logger.dart';
import 'package:log_engine/src/core/caller_context_resolver_factory.dart';
import 'package:log_engine/src/core/log_priority.dart';
import 'package:log_engine/src/remote_logger/remote_logger_interface.dart';

/// [ReleaseLogger] is a logger implementation designed for production environments.
///
/// It filters out logs with priorities below [LogPriority.warn], effectively
/// suppressing `debug` and `info` level logs in production.
///
/// For `error` level logs, it not only logs to the console but also sends
/// the information to a remote logger (e.g., a crash reporting service).
class ReleaseLogger implements BaseLogger {
  /// Creates a [ReleaseLogger].
  ///
  /// Requires an [IRemoteLogger] instance for sending error logs to a remote
  /// logging service.
  ReleaseLogger({required IRemoteLogger remoteLogger}) : _remoteLogger = remoteLogger;
  final IRemoteLogger _remoteLogger;

  /// Logs a message with the specified [priority], [message], and optional
  /// [tag] and [error].
  ///
  /// In production, this method suppresses log messages with priorities lower
  /// than [LogPriority.warn]. For `error` level logs, it also forwards the log
  /// to the remote logger.
  @override
  void log(LogPriority priority, String message, {String? tag, Object? error}) {
    if (priority.value < LogPriority.warn.value) return; // Suppress debug and info logs in production

    final resolvedTag = tag ?? CallerContextResolverFactory.instance.getLogContextResolver().getLogContext();

    developer.log('[RELEASE] $message', name: resolvedTag, error: error);

    if (priority == LogPriority.error && error != null) {
      /// Send the error to a remote crash reporting tool.
      _remoteLogger.log(priority, message, tag: resolvedTag, error: error);
    }
  }

  /// Logs an error message with an optional error object and tag.
  ///
  /// This method will be forwarded to remote logger
  @override
  void error(String message, {Object? error, String? tag}) => log(LogPriority.error, message, error: error, tag: tag);

  @override
  void warn(String message, {String? tag}) => log(LogPriority.warn, message, tag: tag);

  @override
  void debug(String message, {String? tag}) => log(LogPriority.debug, message, tag: tag);

  @override
  void info(String message, {String? tag}) => log(LogPriority.info, message, tag: tag);
}
