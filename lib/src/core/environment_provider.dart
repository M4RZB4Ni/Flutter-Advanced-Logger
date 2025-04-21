/// Environment provider interface
///
/// Provides methods to check the current environment.
abstract class EnvironmentProvider {
  /// Check if the current environment is production.
  bool isProduction();
}
