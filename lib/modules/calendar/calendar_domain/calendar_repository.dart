import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/filters.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/task.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/calendar_repository_impl.dart';

abstract class CalendarRepository {
  factory CalendarRepository(
          {required User user, required AppDatabase appDB, Logger? logger}) =>
      CalendarRepositoryImpl(
          appDB: appDB, user: user, repositoryLogger: logger);

  Future<void> syncCalendarsWithActivities();

  Future<void> syncCalendars();

  /// [end] - not included
  Future<List<Event>> getEventsForPeriod(
      {required DateTime start,
      required DateTime end,
      required List<String> calendarIds});

  Future<List<Task>> getTasks(ActivityFilter filter);

  Future<void> deleteCalendar(Calendar calendar);

  Future<void> unsubscribeFromCalendar(Calendar calendar);

  Future<Calendar> createCalendar(CalendarCreationData data);

  Future<void> createActivity(ActivityCreationData data);

  Future<void> updateCalendar(Calendar calendar);

  Future<void> updateCalendarSharing(Calendar calendar);

  Future<void> updateCalendarPublic(Calendar calendar);

  Future<void> deleteActivity(Activity activity);

  Future<Activity> updateActivity(Activity activity, String originalCalendarId);

  Future<Activity> getActivityByUid(
      {required String calendarId, required String activityUid});

  Future<List<Calendar>> getCalendars();

  Future<void> clearData();
}
