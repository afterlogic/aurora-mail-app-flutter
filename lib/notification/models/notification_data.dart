import 'package:aurora_mail/notification/models/notification_type.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationData {
  final NotificationType type;
  final String subject;
  final String to;
  final String from;
  final String messageId;
  final String folder;
  final String calendarId;
  final String activityId;

  NotificationData({
    required this.type,
    required this.subject,
    required this.to,
    required this.from,
    required this.messageId,
    required this.folder,
    required this.calendarId,
    required this.activityId,
  });

  static NotificationData fromMap(RemoteMessage message) {
    final notification = message.data;
    return fromJson(notification);
  }

  static NotificationData fromJson(Map<String, dynamic> json) {
    final typeString = json["Type"] as String?;
    return NotificationData(
      type: typeString == null
          ? NotificationType.email
          : NotificationTypeMapper.fromString(typeString),
      subject: json["Subject"] as String,
      to: json["To"] as String,
      from: json["From"] as String,
      messageId: json["MessageId"] as String,
      folder: json["Folder"] as String,
      calendarId: json["CalendarId"] as String,
      activityId: json["EventUid"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "Subject": subject,
        "To": to,
        "From": from,
        "MessageId": messageId,
        "Folder": folder,
        "Type": type.toStringCode(),
        "CalendarId": calendarId,
        "EventUid": activityId
      };
}
