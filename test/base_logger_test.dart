import 'package:log_engine/src/core/base_logger.dart';
import 'package:log_engine/src/core/log_priority.dart';
import 'package:test/test.dart';

class MockLogger extends BaseLogger {
  final List<String> logs = [];

  @override
  void log(LogPriority priority, String message, {String? tag, Object? error}) {
    logs.add('$priority: $message');
  }

  @override
  void debug(String message, {String? tag}) => log(LogPriority.debug, message);

  @override
  void info(String message, {String? tag}) => log(LogPriority.info, message);

  @override
  void warn(String message, {String? tag}) => log(LogPriority.warn, message);

  @override
  void error(String message, {Object? error, String? tag}) => log(LogPriority.error, message);
}

void main() {
  group('BaseLogger Tests', () {
    final logger = MockLogger();

    test('Log debug message', () {
      logger.debug('Debug test');
      expect(logger.logs.contains('LogPriority.debug: Debug test'), true);
    });

    test('Log info message', () {
      logger.info('Info test');
      expect(logger.logs.contains('LogPriority.info: Info test'), true);
    });

    test('Log warn message', () {
      logger.warn('Warn test');
      expect(logger.logs.contains('LogPriority.warn: Warn test'), true);
    });

    test('Log error message', () {
      logger.error('Error test');
      expect(logger.logs.contains('LogPriority.error: Error test'), true);
    });
  });
}
