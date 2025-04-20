import 'package:log_engine/src/debug_logger.dart';
import 'package:log_engine/src/logger_provider.dart';
import 'package:log_engine/src/release_logger.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'mocks/logger_test.mocks.dart';

void main() {
  late MockEnvironmentProvider mockEnvironmentProvider;
  late MockIRemoteLogger mockRemoteLogger;

  setUp(() {
    mockEnvironmentProvider = MockEnvironmentProvider();
    mockRemoteLogger = MockIRemoteLogger();
  });

  test('LoggerProvider should throw exception if not initialized', () {
    // We expect the exception to be thrown if LoggerProvider is accessed before initialization.
    expect(() => LoggerProvider.instance, throwsException);
  });

  test('LoggerProvider initializes with DebugLogger in non-production', () async {
    when(mockEnvironmentProvider.isProduction()).thenReturn(false);

    // Await the initialization of LoggerProvider.
    await LoggerProvider.initialize(mockEnvironmentProvider);

    // Now that the provider is initialized, check that the logger is of type DebugLogger.
    expect(LoggerProvider.logger, isA<DebugLogger>());
  });

  test('LoggerProvider initializes with ReleaseLogger in production', () async {
    when(mockEnvironmentProvider.isProduction()).thenReturn(true);
    when(mockRemoteLogger.log(any, any, tag: anyNamed('tag'), error: anyNamed('error'))).thenAnswer((_) {});

    // Ensure that the remote logger is passed when production is true.
    await LoggerProvider.initialize(mockEnvironmentProvider, remoteLogger: mockRemoteLogger);

    // Now that the provider is initialized, check that the logger is of type ReleaseLogger.
    expect(LoggerProvider.logger, isA<ReleaseLogger>());
  });
}
