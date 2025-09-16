part of 'calendar_notification_bloc.dart';

class CalendarNotificationState extends Equatable {
  final NotificationStatus notificationSyncStatus;
  final Displayable? activityFromNotification;
  final ActivityType? activityType;
  final ErrorToShow? error;

  const CalendarNotificationState({
    this.notificationSyncStatus = NotificationStatus.idle,
    this.activityFromNotification,
    this.activityType,
    this.error,
  });

  @override
  List<Object?> get props => [
        notificationSyncStatus,
        activityFromNotification,
        activityType,
        error,
      ];

  CalendarNotificationState copyWith({
    NotificationStatus? notificationSyncStatus,
    Displayable? Function()? activityFromNotification,
    ActivityType? Function()? activityType,
    ErrorToShow? Function()? error,
  }) {
    return CalendarNotificationState(
      notificationSyncStatus:
          notificationSyncStatus ?? this.notificationSyncStatus,
      activityFromNotification: activityFromNotification == null
          ? this.activityFromNotification
          : activityFromNotification(),
      activityType: activityType == null ? this.activityType : activityType(),
      error: error == null ? this.error : error(),
    );
  }
}

enum NotificationStatus { success, error, loading, idle }

extension NotificationStatusX on NotificationStatus {
  bool get isError => this == NotificationStatus.error;

  bool get isLoading => this == NotificationStatus.loading;

  bool get isIdle => this == NotificationStatus.idle;
}
