/// Caller context resolver interface
///
/// This interface defines a contract for resolving the caller context.
abstract class CallerContextResolver {
  /// Retrieves the context of the caller.
  ///
  /// This method should analyze the current call stack and return a
  /// string representation of the caller context. This could be a class
  /// name, method name, file name, or any other relevant information.
  ///
  /// Returns:
  ///   A string representing the caller context.
  String getLogContext();
}

/// Default implementation of caller context resolver
///
/// This class provides a default implementation for the [CallerContextResolver]
/// interface. It attempts to extract the caller context from the current
/// stack trace.
class DefaultCallerContextResolver implements CallerContextResolver {
  @override

  /// {@macro getLogContext}
  String getLogContext() {
    try {
      final stackTraceLines = StackTrace.current.toString().split('\n');

      for (final line in stackTraceLines) {
        if (!_isLoggingRelated(line)) {
          return line.substring(line.indexOf(' ') + 1).trim();
        }
      }
    } catch (_) {
      return 'UnknownCaller';
    }
    return 'UnknownCaller';
  }

  /// Checks if the stack trace line is related to logging.
  ///
  /// This method determines whether a given line from the stack trace is
  /// related to logging by checking for specific keywords.
  ///
  /// Args:
  ///   line: The stack trace line to check.
  /// Returns: True if the line is related to logging, false otherwise.
  bool _isLoggingRelated(String line) {
    return line.contains('Logger') ||
        line.contains('BaseLogger') ||
        line.contains('DebugLogger') ||
        line.contains('ReleaseLogger') ||
        line.contains('SentryLogger') ||
        line.contains('caller_context_resolver.dart');
  }
}
