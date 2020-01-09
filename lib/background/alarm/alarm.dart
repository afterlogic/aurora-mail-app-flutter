import 'dart:io';
import 'dart:ui';

import 'package:alarm_service/alarm_service.dart';
import 'package:flutter/services.dart';

class Alarm {

  static init() {

      AlarmService.init();

  }

  static periodic(Duration duration, Function callback) {

      AlarmService.setAlarm(callback, _id, duration, true);

  }

  static onPeriodic(Function callback) {
      AlarmService.onAlarm(callback, _id);

  }

  static cancel() {
      AlarmService.removeAlarm(_id);

  }

  //close service in background
  static endAlarm() {
      AlarmService.endAlarm();
  }


  static const _id = 752;
}
