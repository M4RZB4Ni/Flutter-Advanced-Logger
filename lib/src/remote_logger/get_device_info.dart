import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:log_engine/src/remote_logger/connectivity_type.dart';
import 'package:log_engine/src/remote_logger/log_entry.dart';

/// An interface for retrieving device information.
abstract interface class IGetDeviceInfo {
  /// Retrieves device information as a [DeviceInfo] object.
  Future<DeviceInfo> getDeviceInformation();
}

/// Implementation of [IGetDeviceInfo] to fetch device details.
class GetDeviceInfo implements IGetDeviceInfo {
  /// Determines the current network connectivity status.
  Future<ConnectivityType> _getNetworkStatus() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return ConnectivityType.wifi;
    } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return ConnectivityType.mobile;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return ConnectivityType.ethernet;
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      return ConnectivityType.bluetooth;
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      return ConnectivityType.vpn;
    } else {
      return ConnectivityType.none;
    }
  }

  Future<Map<String, String>> _getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return {
        'model': androidInfo.model, // Device model
        'os': 'Android ${androidInfo.version.release}', // OS version
      };
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return {
        'model': iosInfo.utsname.machine, // Device model
        'os': 'iOS ${iosInfo.systemVersion}', // OS version
      };
    }

    return {'model': 'Unknown', 'os': 'Unknown'};
  }

  /// Retrieves basic device information (model and OS).
  @override
  Future<DeviceInfo> getDeviceInformation() async {
    final device = await _getDeviceInfo();
    final networkStatus = await _getNetworkStatus();

    return DeviceInfo(
      connectionType: networkStatus.toString(),
      model: device['model']!,
      os: device['os']!,
    );
  }
}
