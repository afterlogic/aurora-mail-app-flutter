import 'dart:io';
import 'package:aurora_mail/build_property.dart';
import 'package:device_id/device_id.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';

class DeviceIdStorage {
  static DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  DeviceIdStorage._();

  static Future<String> getDeviceName() async {
    return BuildProperty.appName +
        " " +
        (Platform.isIOS
            ? (await _deviceInfo.iosInfo).localizedModel
            : (await _deviceInfo.androidInfo).model);
  }

  static Future<String> getDeviceId() async {
    try {
      return (kDebugMode ? "DEBUG" : "") + await DeviceId.getID;
    } catch (_) {
      try {
        return await DeviceId.getIMEI;
      } catch (_) {
        try {
          return await DeviceId.getMEID;
        } catch (_) {
          return null;
        }
      }
    }
  }
}
