import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/services.dart';

class Alarm {
  static const MethodChannel _channel =
      const MethodChannel('ios_alarm_manager');

  static init() {
    if (Platform.isAndroid) {
      AndroidAlarmManager.initialize();
    }
  }

  static periodic(Duration duration, Function callback) {
    if (Platform.isIOS) {
      _iosPeriodic(duration, callback);
    } else {
      AndroidAlarmManager.periodic(duration, _id, callback);
    }
  }

  static cancel() {
    if (Platform.isIOS) {
      _iosCancel();
    } else {
      AndroidAlarmManager.cancel(_id);
    }
  }

  static _iosPeriodic(Duration duration, Function callback) {
    _channel.invokeMethod("periodic", [duration.inSeconds, callback]);
  }

  static _iosCancel() {
    _channel.invokeMethod("cancel");
  }

  static const _id = 752;
}
