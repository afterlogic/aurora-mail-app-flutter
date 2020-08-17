import 'package:flutter/services.dart';

class IosNotificationHandler {
  static bool _isInit = false;
  static final _channel = MethodChannel("ios_notification_handler");

  static Future<Map> _listen() async {
    return _channel.invokeMethod("listen");
  }

  static Future _finish(bool result) {
    return _channel.invokeMethod("finish",[result??false]);
  }

  static onMessage(Future<bool> Function(Map<String, dynamic> message) onMessage) async {
    if (_isInit) throw "_isInit == true";
    _isInit = true;
    while (true) {
      final map = await _listen();
      final result=await onMessage(Map<String, dynamic>.from(map));
      await _finish(result);
    }
  }
}