part of 'calendar_notification_bloc.dart';

class CalendarNotificationState extends Equatable {
  final NotificationStatus notificationSyncStatus;
  final Displayable? activityFromNotification;
  final ActivityType? activityType;
  final ErrorToShow? error;

  @override
  List<Object?> get props =>
      [notificationSyncStatus, activityFromNotification, error];

  const CalendarNotificationState(
      {this.notificationSyncStatus = NotificationStatus.idle,
      this.error,
      this.activityType,
      this.activityFromNotification});

  CalendarNotificationState copyWith({
    NotificationStatus? notificationSyncStatus,
    Displayable? Function()? activityFromNotification,
    ActivityType? Function()? activityType,
    ErrorToShow? Function()? error,
  }) {
    return CalendarNotificationState(
        notificationSyncStatus:
            notificationSyncStatus ?? this.notificationSyncStatus,
        error: error == null ? this.error : error(),
        activityType: activityType == null ? this.activityType : activityType(),
        activityFromNotification: activityFromNotification == null
            ? this.activityFromNotification
            : activityFromNotification());
  }
}

enum NotificationStatus { success, error, loading, idle }

extension NotificationStatusX on NotificationStatus {
  bool get isError => this == NotificationStatus.error;
  bool get isLoading => this == NotificationStatus.loading;
  bool get isIdle => this == NotificationStatus.idle;
}
