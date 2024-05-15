import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/calendar_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/event_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/event_update_info_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar/calendar_dao.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar_db_service.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/event/event_dao.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/event/event_update_info.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/event/event_update_info_dao.dart';

class CalendarDbServiceImpl implements CalendarDbService {
  CalendarDbServiceImpl(AppDatabase db)
      : _calendarDao = CalendarDao(db),
        _eventDao = EventDao(db),
        _updateInfoDao = EventUpdateInfoDao(db);

  final CalendarDao _calendarDao;
  final EventDao _eventDao;
  final EventUpdateInfoDao _updateInfoDao;

  @override
  Future<List<Calendar>> getCalendars(int userLocalId) async {
    final entries = await _calendarDao.getAllCalendars(userLocalId);
    return CalendarMapper.listFromDB(entries);
  }

  @override
  Future<List<Event>> getEvents(String calendarId, int userLocalId) async {
    final entries =
        await _eventDao.getAllEventsFromCalendar(calendarId, userLocalId);
    return EventMapper.listFromDB(entries);
  }

  @override
  Future<void> createOrUpdateEventUpdateInfoList(
      List<EventUpdateInfo> events) async {
    return _updateInfoDao.upsert(EventUpdateInfoMapper.listToDB(events));
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
      await _updateInfoDao.deleteAllInfoFromCalendar(c.id, c.userLocalId);
    }
  }

  /// all events that not contain id from [calendars] will be deleted
  @override
  Future<void> clearEvents(List<Calendar> calendars) async {
    final calendarIds = calendars.map((e) => e.id).toList();
    final userIds = calendars.map((e) => e.userLocalId).toList();

    await _eventDao.deleteAllUnusedEvents(calendarIds, userIds);
    await _updateInfoDao.deleteAllUnusedInfo(calendarIds, userIds);
  }

  @override
  Future<List<EventUpdateInfo>> getEventUpdateInfoList({int limit = 10}) async {
    final entries = await _updateInfoDao.getList(limit);
    return EventUpdateInfoMapper.listFromDB(entries);
  }

  @override
  Future<void> createOrUpdateEventList(List<Event> events) {
    return _eventDao
        .createOrUpdateEventList(EventMapper.listToDB(events: events));
  }

  @override
  Future<void> deleteEventsByInfo(List<EventUpdateInfo> infoList) async {
    for (final info in infoList) {
      await _eventDao.deleteEvent(
          uid: info.uid,
          calendarId: info.calendarId,
          userLocalId: info.userLocalId);
    }
  }

  @override
  Future<void> deleteEventUpdateInfoList(List<EventUpdateInfo> infoList) async{
    for (final info in infoList) {
      await _updateInfoDao.deleteInfoFromCalendar(
          uid: info.uid,
          calendarUUID: info.calendarId,
          userLocalId: info.userLocalId);
    }
  }
}
