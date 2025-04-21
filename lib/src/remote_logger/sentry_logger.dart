import 'package:log_engine/src/core/log_priority.dart';
import 'package:log_engine/src/remote_logger/remote_logger_interface.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryLogger implements IRemoteLogger {
  Future<void> init(String dns) async {
    await SentryFlutter.init((options) {
      options.dsn = dns;
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    });
  }

  @override
  void log(LogPriority priority, String message, {String? tag, Object? error}) {
    Sentry.captureException(
      error,
      stackTrace: StackTrace.current,
    );
  }
}
