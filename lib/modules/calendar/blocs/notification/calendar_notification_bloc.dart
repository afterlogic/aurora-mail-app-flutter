import 'dart:async';

import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/ui/models/displayable.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calendar_notification_event.dart';
part 'calendar_notification_state.dart';

class CalendarNotificationBloc
    extends Bloc<CalendarNotificationEvent, CalendarNotificationState> {
  final CalendarUseCase _useCase;

  CalendarNotificationBloc({required CalendarUseCase useCase})
      : _useCase = useCase,
        super(CalendarNotificationState()) {
    on<StartSyncFromNotification>(_onStartSyncFromNotification);
  }

  _onStartSyncFromNotification(StartSyncFromNotification event,
      Emitter<CalendarNotificationState> emit) async {
    emit(state.copyWith(notificationSyncStatus: NotificationStatus.loading));
    try {
      await _useCase.syncCalendarsWithActivities();
      final selectedEvent = await _useCase.getActivityByUid(
          calendarId: event.calendarId, activityId: event.activityId);
      emit(state.copyWith(
          activityFromNotification: () => selectedEvent,
          activityType: () => event.activityType));
    } catch (e, s) {
      emit(
        state.copyWith(
          notificationSyncStatus: NotificationStatus.error,
          error: () => formatError(e, s),
        ),
      );
    } finally {
      emit(state.copyWith(
          notificationSyncStatus: NotificationStatus.idle,
          error: () => null,
          activityType: () => null,
          activityFromNotification: () => null));
    }
  }
}
