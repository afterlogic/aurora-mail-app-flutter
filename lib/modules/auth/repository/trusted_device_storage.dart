import 'dart:io';

import 'package:device_info/device_info.dart';

class TrustedDeviceStorage {
  static DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<String> getDeviceId() async {
    return Platform.isIOS
        ? (await _deviceInfo.iosInfo).model
        : (await _deviceInfo.androidInfo).model;
  }
}
