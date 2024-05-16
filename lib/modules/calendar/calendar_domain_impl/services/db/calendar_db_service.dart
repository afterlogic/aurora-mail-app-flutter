import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar_db_service_impl.dart';


abstract class CalendarDbService {
  factory CalendarDbService(AppDatabase db) {
    return CalendarDbServiceImpl(db);
  }

  Future<List<Calendar>> getCalendars(int userLocalId);

  Future<void> emitChanges(List<EventBase> events);

  Future<void> createOrUpdateCalendar(Calendar calendar);

  Future<void> deleteCalendars(List<Calendar> calendars);

  Future<void> clearEvents(List<Calendar> calendars);

  Future<List<Event>> getNotUpdatedEvents({required int limit, required int offset});

  Future<void> updateEventList(List<Event> events);

  Future<void> deleteMarkedEvents();

}
