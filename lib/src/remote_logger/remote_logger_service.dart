import 'package:log_engine/src/remote_logger/remote_logger_interface.dart';
import 'package:log_engine/src/remote_logger/sentry_logger.dart';

class RemoteLoggerService {
  RemoteLoggerService({IRemoteLogger? remoteLogger, String? sentryDns}) : _remoteLogger = remoteLogger ?? SentryLogger() {
    _init(sentryDns: sentryDns);
  }

  final IRemoteLogger _remoteLogger;

  Future<void> _init({String? sentryDns}) async {
    if (_remoteLogger is SentryLogger && sentryDns != null) {
      await _remoteLogger.init(sentryDns);
    }
  }

  void log(dynamic exception, dynamic stackTrace) async {
    _remoteLogger.log(exception, stackTrace);
  }
}
