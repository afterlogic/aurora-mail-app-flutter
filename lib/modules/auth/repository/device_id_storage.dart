
import 'dart:io';
import 'package:aurora_mail/build_property.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceIdStorage {
  static DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  DeviceIdStorage._();

  static Future<String> getDeviceName() async {
    String device;
    if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      device = "${info.name} ${info.systemName} ${info.systemVersion}";
    } else {
      device = (await _deviceInfo.androidInfo).model;
    }
    return BuildProperty.appName + " " + device;
  }

  static Future<String?> getDeviceId() async {
    if (Platform.isIOS) {
     return (await _deviceInfo.iosInfo).identifierForVendor;
    } else if(Platform.isAndroid) {
      return (await _deviceInfo.androidInfo).id;
    } else {
      return null;
    }
  }
}
