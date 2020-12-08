import 'dart:io';

import 'package:device_id/device_id.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';

class DeviceIdStorage {
  static DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  DeviceIdStorage._();

  static Future<String> getDeviceName() async {
    return Platform.isIOS
        ? (await _deviceInfo.iosInfo).model
        : (await _deviceInfo.androidInfo).model;
  }

  static Future<String> getDeviceId() async {
    try {
      return (kDebugMode ? "debug" : "release") + await DeviceId.getID;
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
