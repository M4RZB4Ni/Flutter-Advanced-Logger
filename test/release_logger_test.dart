import 'package:log_engine/src/core/log_priority.dart';
import 'package:log_engine/src/core/release_logger.dart';
import 'package:log_engine/src/remote_logger/remote_logger_interface.dart';
import 'package:test/test.dart';

class MockRemoteLogger implements IRemoteLogger {
  bool logCalled = false;
  dynamic loggedException;
  dynamic loggedStackTrace;
  late LogPriority priority;
  late String message;

  @override
  void log(LogPriority priority, String message, {String? tag, Object? error}) {
    this.priority = priority;
    this.message = message;
    if (error != null) {
      loggedException = error;
    }
    logCalled = true;
  }
}

void main() {
  group('ReleaseLogger Tests', () {
    late MockRemoteLogger mockRemoteLogger;
    late ReleaseLogger releaseLogger;

    setUp(() {
      mockRemoteLogger = MockRemoteLogger();
      releaseLogger = ReleaseLogger(remoteLogger: mockRemoteLogger);
    });

    test('Should log error with remote logger', () async {
      const message = 'Error message';
      final exception = Exception('Test exception');

      releaseLogger.error(message, error: exception);

      await Future.delayed(Duration(milliseconds: 10));

      expect(mockRemoteLogger.logCalled, true);
      expect(mockRemoteLogger.loggedException, exception);
      expect(mockRemoteLogger.message, message);
      expect(mockRemoteLogger.priority, LogPriority.error); // Assuming LogPriority.error is the expected priority
    });

    test('Should suppress debug and info logs in production', () {
      releaseLogger.debug('Debug message');
      releaseLogger.info('Info message');

      expect(mockRemoteLogger.logCalled, false);
    });

    test('Should log warnings without triggering remote logger', () {
      releaseLogger.warn('Warning message');

      expect(mockRemoteLogger.logCalled, false);
    });

    test('Should not throw when log context resolution fails', () {
      expect(() => releaseLogger.log(LogPriority.error, 'Error message'), returnsNormally);
    });
  });
}
