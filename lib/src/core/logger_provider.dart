import 'package:log_engine/src/core/base_logger.dart';
import 'package:log_engine/src/core/debug_logger.dart';
import 'package:log_engine/src/core/environment_provider.dart';
import 'package:log_engine/src/core/release_logger.dart';
import 'package:log_engine/src/remote_logger/default_remote_logger.dart';
import 'package:log_engine/src/remote_logger/remote_logger_interface.dart';

/// [LoggerProvider] is a class responsible for providing a logger instance.
/// It uses the [EnvironmentProvider] to determine whether to use the
/// [DebugLogger] or the [ReleaseLogger].
/// It also provides a static method to initialize the logger.
class LoggerProvider {
  LoggerProvider._internal(EnvironmentProvider environmentProvider) {
    _environmentProvider = environmentProvider;
    if (_environmentProvider.isProduction()) {
      _logger = ReleaseLogger(remoteLogger: _remoteLogger);
    } else {
      _logger = DebugLogger();
    }
  }

  /// Initializes the logger provider.
  ///
  /// The [environmentProvider] is used to determine the environment.
  /// If the environment is production, the [remoteLogger] is used to log
  /// to a remote server. If no [remoteLogger] is provided, the
  /// [DefaultRemoteLogger] is used.
  ///
  static Future<void> initialize(EnvironmentProvider environmentProvider, {IRemoteLogger? remoteLogger}) async {
    if (environmentProvider.isProduction()) {
      _remoteLogger = remoteLogger ?? await DefaultRemoteLogger.getInstance();
    }
    _instance ??= LoggerProvider._internal(environmentProvider);
  }

  /// Returns the logger provider instance.
  ///
  /// Throws an exception if the logger provider has not been initialized.
  ///
  static LoggerProvider get instance {
    if (_instance == null) {
      throw Exception('Please call initialize() first.');
    }
    return _instance!;
  }

  static LoggerProvider? _instance;
  static late final BaseLogger _logger;
  late final EnvironmentProvider _environmentProvider;
  static late final IRemoteLogger _remoteLogger;

  /// Returns the base logger instance.
  static BaseLogger get logger => _logger;
}
