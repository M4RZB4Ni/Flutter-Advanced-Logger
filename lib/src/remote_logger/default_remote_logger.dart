import 'package:log_engine/src/core/log_priority.dart';
import 'package:log_engine/src/remote_logger/get_app_info.dart';
import 'package:log_engine/src/remote_logger/get_device_info.dart';
import 'package:log_engine/src/remote_logger/log_entry.dart';
import 'package:log_engine/src/remote_logger/remote_logger_interface.dart';

class DefaultRemoteLogger implements IRemoteLogger {
  DefaultRemoteLogger._(this._getDeviceInfo, this._getAppInfo);

  static DefaultRemoteLogger? _instance;
  final IGetDeviceInfo _getDeviceInfo;
  final IGetAppInfo _getAppInfo;
  late final DeviceInfo? _deviceInfo;
  late final String? _appVersion;

  static Future<DefaultRemoteLogger> getInstance({
    IGetDeviceInfo? getDeviceInfo,
    IGetAppInfo? getAppInfo,
  }) async {
    if (_instance == null) {
      _instance = DefaultRemoteLogger._(
        getDeviceInfo ?? GetDeviceInfo(),
        getAppInfo ?? GetAppInfo(),
      );
      await _instance!._initialize();
    }

    return _instance!;
  }

  Future<void> _initialize() async {
    _deviceInfo = await _getDeviceInfo.getDeviceInformation();
    _appVersion = await _getAppInfo.getAppVersion();
  }

  @override
  void log(LogPriority priority, String message, {String? tag, Object? error}) {
    if (_deviceInfo == null || _appVersion == null) {
      throw Exception('DefaultRemoteLogger initialize is not called to gather device information and app version');
    }
    final logEntry = LogEntry(
      timestamp: DateTime.now().toUtc().toIso8601String(),
      level: priority.toString(),
      message: message,
      device: _deviceInfo,
      appVersion: _appVersion,
    );
  }

  ///todo: You can ask core team to prepare a default remote logger mechanism on back-end to send the [logEntry] to it
}
