import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/calendar_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar/calendar_dao.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar_db_service.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/event/event_dao.dart';

class CalendarDbServiceImpl implements CalendarDbService {
  CalendarDbServiceImpl(AppDatabase db)
      : _calendarDao = CalendarDao(db),
        _eventDao = EventDao(db);

  final CalendarDao _calendarDao;
  final EventDao _eventDao;

  @override
  Future<List<Calendar>> getCalendars(int userLocalId) async {
    final entries = await _calendarDao.getAllCalendars(userLocalId);
    return CalendarMapper.listFromDB(entries);
  }


  @override
  Future<void> emitChanges(
      List<EventBase> events) async {
    return _eventDao.createOrUpdateEventList(events.map((e) => e.toDb()).toList());
  }

  @override
  Future<void> createOrUpdateCalendar(Calendar calendar) {
    return _calendarDao
        .createOrUpdateCalendar(CalendarMapper.toDB(calendar: calendar));
  }

  @override
  Future<void> deleteCalendars(List<Calendar> calendars) async {
    await _calendarDao.deleteCalendars(calendars.map((e) => e.id).toList());
    for (final c in calendars) {
      await _eventDao.deleteAllEventsFromCalendar(c.id, c.userLocalId);
    }
  }

  /// all events that not contain id from [calendars] will be deleted
  @override
  Future<void> clearEvents(List<Calendar> calendars) async {
    final calendarIds = calendars.map((e) => e.id).toList();
    final userIds = calendars.map((e) => e.userLocalId).toList();
    await _eventDao.deleteAllUnusedEvents(calendarIds, userIds);
  }



  @override
  Future<void> updateEventList(List<Event> events) {
    return _eventDao
        .createOrUpdateEventList(events.map((e) => e.toDb()).toList(), synced: true);
  }

  @override
  Future<void> deleteMarkedEvents() async {
    final deletedCount =
    await _eventDao.deleteMarkedEvents();
    print(deletedCount);
  }

  @override
  Future<List<Event>> getNotUpdatedEvents({required int limit, required int offset}) async{
    final result = await _eventDao.getEventsWithLimit(limit: limit, offset: offset);
    return result.map((e) => Event.fromDb(e)).where((e) => !e.synced).toList();
  }
}
