import 'dart:io';
import 'dart:ui';

import 'package:alarm_service/alarm_service.dart';
import 'package:flutter/services.dart';

class Alarm {
  static const MethodChannel _channel =
      const MethodChannel('ios_alarm_manager');

  static periodic(Duration duration, Function callback) {
    if (Platform.isIOS) {
      _iosPeriodic(duration, callback);
    } else {
      AlarmService.setAlarm(callback, _id, duration, true);
    }
  }

  static cancel() {
    if (Platform.isIOS) {
      _iosCancel();
    } else {
      AlarmService.cancelAlarm(_id);
    }
  }

  static endAlarm() {
    if (Platform.isIOS) {
//todo
    } else {
      AlarmService.endAlarm();
    }
  }

  static _iosPeriodic(Duration duration, Function callback) {
    _channel.invokeMethod("periodic", [
      duration.inSeconds,
      PluginUtilities.getCallbackHandle(callback).toRawHandle()
    ]);
  }

  static _iosCancel() {
    _channel.invokeMethod("cancel");
  }

  static const _id = 752;
}
