import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart';

class AlarmService {
  static const MethodChannel _channel = const MethodChannel('alarm_service');
  static final Map<int, Function> _onAlarmMap = {};

  static Future setAlarm(
    Function onAlarm,
    int id,
    Duration interval,
    bool repeat,
  ) {
    return _channel.invokeMethod('setAlarm', [
      PluginUtilities.getCallbackHandle(onAlarm).toRawHandle(),
      id,
      interval.inSeconds,
      repeat,
    ]);
  }

  static Future endAlarm() {
    return _channel.invokeMethod('endAlarm');
  }

  static Future<bool> isAlarm() {
    return _channel.invokeMethod('isAlarm');
  }

  static Future cancelAlarm(int id) {
    _onAlarmMap.remove(id);
    return _channel.invokeMethod('cancelAlarm', [id]);
  }

  static onAlarm(
    Function onAlarm,
    int id,
  ) {
    final isEmpty = _onAlarmMap.isEmpty;
    _onAlarmMap[id] = onAlarm;
    if (isEmpty) {
      _doOnAlarm();
    }
  }

  static _doOnAlarm() async {
    while (_onAlarmMap.isNotEmpty) {
      final id = await _channel.invokeMethod('doOnAlarm');
      if (id != null) {
        final function = _onAlarmMap[id];
        if (function != null) function();
      }
    }
  }
}
