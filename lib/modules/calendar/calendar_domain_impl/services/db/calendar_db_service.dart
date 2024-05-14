import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar_db_service_impl.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/event/event_update_info.dart';


abstract class CalendarDbService {
  factory CalendarDbService(AppDatabase db) {
    return CalendarDbServiceImpl(db);
  }

  Future<List<Calendar>> getCalendars(int userLocalId);

  Future<List<Event>> getEvents(String calendarId);

  Future<void> createOrUpdateEventUpdateInfoList(List<EventUpdateInfo> events);

  Future<void> createOrUpdateCalendar(Calendar calendar);
}
