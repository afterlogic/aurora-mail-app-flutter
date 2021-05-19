import 'dart:io';
import 'dart:ui';

import 'package:alarm_service/alarm_service.dart';

class BackgroundHelper {
  static var _current = AppLifecycleState.detached;

  static void set current(AppLifecycleState value) {
    if (Platform.isIOS) {
      final nowIsBackground = _current != AppLifecycleState.resumed;
      final afterIsBackground = value != AppLifecycleState.resumed;
      if (nowIsBackground != afterIsBackground) {
        if (afterIsBackground) {
          AlarmService.stopTimer();
        } else {
          AlarmService.startTimer();
        }
      }
    }
    _current = value;
  }

  static bool appIsRunning = false;

  static AppLifecycleState get current => _current;

  static Map<Function, bool> _doOnAlarm = {};

  static Map<Function(bool hasUpdate), bool> _doOnEndAlarm = {};

  static bool get isBackground => current != AppLifecycleState.resumed;

  static addOnAlarmObserver(bool callInBackground, Function doOnAlarm) {
    _doOnAlarm[doOnAlarm] = callInBackground;
  }

  static removeOnAlarmObserver(Function doOnAlarm) {
    _doOnAlarm.remove(doOnAlarm);
  }

  static addOnEndAlarmObserver(
      bool callInBackground, Function(bool hasUpdate) doOnAlarm) {
    _doOnEndAlarm[doOnAlarm] = callInBackground;
  }

  static removeOnEndAlarmObserver(Function(bool hasUpdate) doOnAlarm) {
    _doOnEndAlarm.remove(doOnAlarm);
  }

  static onStartAlarm() {
    final isBackground = BackgroundHelper.isBackground;
    _doOnAlarm.forEach((doOnAlarm, callInBackground) {
      if (callInBackground || !isBackground) {
        doOnAlarm();
      }
    });
  }

  static onEndAlarm(bool hasUpdate) {
    final isBackground = BackgroundHelper.isBackground;
    _doOnEndAlarm.forEach((doOnAlarm, callInBackground) {
      if (callInBackground || !isBackground) {
        doOnAlarm(hasUpdate);
      }
    });
  }
}
