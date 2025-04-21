import 'dart:developer' as developer;

import 'package:log_engine/src/core/base_logger.dart';
import 'package:log_engine/src/core/caller_context_resolver_factory.dart';
import 'package:log_engine/src/core/log_priority.dart';

///Implementation of [BaseLogger] that logs using the dart:developer package
class DebugLogger implements BaseLogger {
  ///Logs the [message] with the specified [priority] and optional [tag] and [error].
  ///
  ///If no [tag] is specified, it will attempt to resolve one automatically.
  @override
  void log(LogPriority priority, String message, {String? tag, Object? error}) {
    final resolvedTag = tag ?? CallerContextResolverFactory.instance.getLogContextResolver().getLogContext();
    developer.log(message, name: resolvedTag, error: error);
  }

  ///Logs the [message] with [LogPriority.debug] and optional [tag].
  ///
  ///If no [tag] is specified, it will attempt to resolve one automatically.
  @override
  void debug(String message, {String? tag}) => log(LogPriority.debug, message, tag: tag);

  ///Logs the [message] with [LogPriority.error] and optional [tag] and [error].
  ///
  ///If no [tag] is specified, it will attempt to resolve one automatically.
  @override
  void error(String message, {Object? error, String? tag}) => log(LogPriority.error, error: error, message, tag: tag);

  ///Logs the [message] with [LogPriority.info] and optional [tag].
  ///
  ///If no [tag] is specified, it will attempt to resolve one automatically.
  @override
  void info(String message, {String? tag}) => log(LogPriority.info, message, tag: tag);

  ///Logs the [message] with [LogPriority.warn] and optional [tag].
  ///
  ///If no [tag] is specified, it will attempt to resolve one automatically.
  @override
  void warn(String message, {String? tag}) => log(LogPriority.warn, message, tag: tag);
}
