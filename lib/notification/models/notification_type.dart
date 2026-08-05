enum NotificationType { email, event, task }

extension NotificationTypeMapper on NotificationType {
  static NotificationType fromString(String s) {
    switch (s) {
      case 'event':
        return NotificationType.event;
      case 'task':
        return NotificationType.task;
      case 'email':
      default:
        return NotificationType.email;
    }
  }

  String toStringCode() {
    switch (this) {
      case NotificationType.event:
        return 'event';
      case NotificationType.task:
        return 'task';
      case NotificationType.email:
        return 'email';
    }
  }
}
