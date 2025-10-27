import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  final DeviceInfoPlugin deviceInfo;
  DeviceInfo(this.deviceInfo);

  Future<String> getDeviceName() async {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.name;
    } else {
      return "WEB";
    }
  }
}
