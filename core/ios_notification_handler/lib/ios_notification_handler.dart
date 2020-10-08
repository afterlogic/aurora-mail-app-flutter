import 'package:flutter/services.dart';

class IosNotificationHandler {
  static bool _isInit = false;
  static final _channel = MethodChannel("ios_notification_handler");

  static Future<Map> _listen() async {
    return _channel.invokeMethod("listen");
  }

  static Future<bool> isBackground() async {
    try {
      final result = await _channel.invokeMethod("isBackground");
      if (result != 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future _finish(bool result) {
    return _channel.invokeMethod("finish", [result ?? false]);
  }

  static onMessage(Future<bool> Function(Map<String, dynamic> message) onMessage) async {
    if (_isInit) throw "_isInit == true";
    _isInit = true;
    while (true) {
      try {
        final map = await _listen();
        print(map);
        final result = await onMessage(Map<String, dynamic>.from(map));
        await _finish(result);
      } catch (e) {
        print(e);
      }
    }
  }
}
