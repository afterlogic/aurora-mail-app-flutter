import 'package:aurora_mail/notification/models/notification_type.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationData {
  final NotificationType type;
  final String subject;
  final String to;
  final String from;
  final String messageID;
  final String folder;
  final String calendarId;
  final String activityId;

  NotificationData(
    this.type,
    this.subject,
    this.to,
    this.from,
    this.messageID,
    this.folder,
    this.calendarId,
    this.activityId,
  );

  static NotificationData fromMap(RemoteMessage message) {
    final notification = message.data;
    return fromJson(notification);
  }

  static NotificationData fromJson(Map<String, dynamic> json) {
    final typeString = json["Type"] as String?;
    return NotificationData(
      typeString == null
          ? NotificationType.email
          : NotificationTypeMapper.fromString(typeString),
      json["Subject"] as String,
      json["To"] as String,
      json["From"] as String,
      json["MessageId"] as String,
      json["Folder"] as String,
      json["CalendarId"] as String,
      json["EventUid"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "Subject": subject,
        "To": to,
        "From": from,
        "MessageId": messageID,
        "Folder": folder,
        "Type": type == null ? null : type.toStringCode(),
        "CalendarId": calendarId,
        "EventUid": activityId
      };
}
