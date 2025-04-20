import 'package:package_info_plus/package_info_plus.dart';

abstract interface class IGetAppInfo {
  Future<String> getAppVersion();
}

class GetAppInfo implements IGetAppInfo {
  @override
  Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.version;
  }
}
