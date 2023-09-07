import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'models/status_bar_notification.dart';

class NotificationsUtils {
  static const MethodChannel _channel =
      const MethodChannel('notifications_utils');

  static Future<List<StatusBarNotification>> getActiveNotifications() async {
    if (!Platform.isAndroid) {
      throw UnsupportedError("This feature is only supported on Android 24+");
    }
    final List activeNotifications =
        await _channel.invokeMethod('getActiveNotifications');
    return activeNotifications.map((n) {
      return StatusBarNotification.fromMap(n as Map);
    }).toList();
  }
}
