import 'package:log_engine/src/core/debug_logger.dart';
import 'package:test/test.dart';

void main() {
  group('DebugLogger Tests', () {
    final logger = DebugLogger();

    /// returnsNormally: Ensures that the given function or block of code executes without throwing any exceptions.
    test('Log info message', () {
      expect(() => logger.info('Info message'), returnsNormally);
    });

    test('Log debug message', () {
      expect(() => logger.debug('Debug message'), returnsNormally);
    });

    test('Log warning message', () {
      expect(() => logger.warn('Warning message'), returnsNormally);
    });

    test('Log error message', () {
      expect(() => logger.error('Error message'), returnsNormally);
    });
  });
}
