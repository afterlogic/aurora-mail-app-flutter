import 'dart:io';
import 'package:aurora_mail/build_property.dart';
import 'package:device_id/device_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

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

  static Future<bool> isAndroid10orHigh() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      final sdkVersion = androidInfo.version.sdkInt;
      // for Android 10 or high
      if (sdkVersion != null && sdkVersion >= 29) {
        return true;
      }
    }
    return false;
  }
}
