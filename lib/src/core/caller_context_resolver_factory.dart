import 'package:log_engine/src/core/caller_context_resolver.dart';

/// [CallerContextResolverFactory] is a factory for managing [CallerContextResolver] instances.
///
/// It allows to set a custom [CallerContextResolver] implementation or to use the default one.
class CallerContextResolverFactory {
  CallerContextResolverFactory._internal();

  /// Singleton instance
  static final CallerContextResolverFactory instance = CallerContextResolverFactory._internal();

  CallerContextResolver? _customInstance;

  /// Gets the current [CallerContextResolver] implementation.
  ///
  /// If a custom implementation has been set via [setCustomImplementation], it will be returned.
  /// Otherwise, the default [DefaultCallerContextResolver] will be returned.
  CallerContextResolver getLogContextResolver() {
    return _customInstance ?? DefaultCallerContextResolver();
  }

  /// Sets a custom [CallerContextResolver] implementation.
  ///
  /// From this point, all calls to [getLogContextResolver] will return the provided [resolver].
  void setCustomImplementation(CallerContextResolver resolver) {
    _customInstance = resolver;
  }

  /// Resets the [CallerContextResolver] implementation to the default one.
  ///
  /// After this call, [getLogContextResolver] will return the [DefaultCallerContextResolver].
  void resetToDefault() {
    _customInstance = null;
  }
}
