import 'package:log_engine/src/remote_logger/remote_logger_interface.dart';
import 'package:log_engine/src/remote_logger/sentry_logger.dart';

/// A service for handling remote logging, allowing for different logging implementations.
class RemoteLoggerService {
  /// Creates a [RemoteLoggerService].
  ///
  /// If no [remoteLogger] is provided, it defaults to using [SentryLogger].
  /// If [sentryDns] is provided and the logger is a [SentryLogger], it initializes Sentry.
  RemoteLoggerService({IRemoteLogger? remoteLogger, String? sentryDns}) : _remoteLogger = remoteLogger ?? SentryLogger() {
    _init(sentryDns: sentryDns);
  }

  final IRemoteLogger _remoteLogger;

  /// Initializes the remote logger.
  ///
  /// For [SentryLogger], it initializes the logger with the provided [sentryDns].
  Future<void> _init({String? sentryDns}) async {
    if (_remoteLogger is SentryLogger && sentryDns != null) {
      await _remoteLogger.init(sentryDns);
    }
  }

  /// Logs an exception with its stack trace using the configured remote logger.
  void log(dynamic exception, dynamic stackTrace) async {
    _remoteLogger.log(exception, stackTrace);
  }
}
