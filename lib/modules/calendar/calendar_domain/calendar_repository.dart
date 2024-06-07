import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/calendar_repository_impl.dart';

abstract class CalendarRepository {
  factory CalendarRepository({
    required User user,
    required AppDatabase appDB,
  }) =>
      CalendarRepositoryImpl(
        appDB: appDB,
        user: user,
      );

  Future<void> syncCalendars();

  /// [end] - not included
  Future<List<Event>> getForPeriod(
      {required DateTime start,
      required DateTime end,
      required List<String> calendarIds});

  Future<void> deleteCalendar(Calendar calendar);

  Future<Calendar> createCalendar(CalendarCreationData data);

  Future<void> createEvent(EventCreationData data);

  Future<void> updateCalendar(Calendar calendar);

  Future<void> deleteEvent(Event event);

  Future<Event> updateEvent(Event event);

  Future<List<Calendar>> getCalendars();
}
