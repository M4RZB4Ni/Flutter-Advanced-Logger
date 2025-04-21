import 'package:package_info_plus/package_info_plus.dart';

/// An interface for retrieving application information.
abstract interface class IGetAppInfo {
  /// Retrieves the application's version.
  Future<String> getAppVersion();
}

/// Implementation of [IGetAppInfo] to fetch application details.
class GetAppInfo implements IGetAppInfo {
  @override
  Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.version;
  }
}
