import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/filters.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar_db_service_impl.dart';

abstract class CalendarDbService {
  factory CalendarDbService(AppDatabase db) {
    return CalendarDbServiceImpl(db);
  }

  Future<List<Calendar>> getCalendars(int userLocalId);

  Future<void> emitChanges(List<ActivityBase> events);

  Future<void> createOrUpdateCalendar(Calendar calendar);

  Future<void> deleteCalendars(List<Calendar> calendars);

  Future<void> clearEvents(List<Calendar> calendars);

  Future<List<ActivityBase>> getNotUpdatedEvents(
      {required int? limit, required int? offset});

  Future<void> updateEventList(List<Activity> events);

  Future<void> deleteMarkedEvents();

  Future<List<Activity>> getActivitiesForPeriod(
      {required DateTime start,
      required DateTime end,
      required List<String> calendarIds,
      required int userLocalId});

  Future<List<Activity>> getActivities(
      {required ActivityFilter filter,
      required List<String>? calendarIds,
      ActivityType? type,
      required int userLocalId});

  //TODO get tasks for period

  //TODO get all tasks

  Future<void> clearData();
}
