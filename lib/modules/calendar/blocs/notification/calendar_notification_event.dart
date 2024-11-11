part of 'calendar_notification_bloc.dart';

abstract class CalendarNotificationEvent extends Equatable {
  const CalendarNotificationEvent();

  @override
  List<Object?> get props => [];
}

class StartSyncFromNotification extends CalendarNotificationEvent {
  final String calendarId;
  final String activityId;
  final ActivityType activityType;
  const StartSyncFromNotification(
      {required this.calendarId,
      required this.activityId,
      required this.activityType});

  @override
  List<Object?> get props => [calendarId, activityId, activityType];
}
