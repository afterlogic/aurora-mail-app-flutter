import 'dart:async';

import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/filters.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/calendar_usecase_impl.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/models/displayable.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/models/task.dart';
import 'package:rxdart/streams.dart';
import 'package:timezone/timezone.dart' as tz;

abstract class CalendarUseCase {
  factory CalendarUseCase(
          {required CalendarRepository repository, tz.Location? location}) =>
      CalendarUseCaseImpl(repository: repository, location: location);

  ValueStream<List<ViewCalendar>> get calendarsSubscription;

  ValueStream<List<ViewEvent>> get eventsSubscription;

  ValueStream<List<ViewTask>> get tasksSubscription;

  Future<void> syncCalendars();

  Future<void> getTasks();

  Future<void> getForPeriod({required DateTime start, required DateTime end});

  Future<void> createCalendar(CalendarCreationData data);

  Future<void> createActivity(ActivityCreationData data);

  Future<void> updateCalendar(ViewCalendar calendar);

  Future<void> updateCalendarPublic(ViewCalendar calendar);

  Future<void> updateCalendarSharing(ViewCalendar calendar);

  Future<Displayable> updateActivity(Displayable activity);

  Future<void> deleteEvent(ViewEvent event);

  Future<void> deleteCalendar(ViewCalendar calendar);

  Future<void> getCalendars();

  Future<void> clearData();

  void updateSelectedCalendarIds(
      {required String selectedId, bool isAdded = true});

  void updateTasksFilter(ActivityFilter filter);
}
