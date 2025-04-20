import 'package:log_engine/src/remote_logger/remote_logger_interface.dart';
import 'package:log_engine/src/remote_logger/sentry_logger.dart';

class RemoteLoggerService {
  RemoteLoggerService({IRemoteLogger? remoteLogger}) : _remoteLogger = remoteLogger ?? SentryLogger() {
    _init();
  }

  final IRemoteLogger _remoteLogger;

  Future<void> _init() async {
    if (_remoteLogger is SentryLogger) {
      await _remoteLogger.init();
    }
  }

  void log(dynamic exception, dynamic stackTrace) async {
    _remoteLogger.log(exception, stackTrace);
  }
}
