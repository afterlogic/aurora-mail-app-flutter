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
  Future<List<Event>> getEvents(String calendarId) async {
    final entries = await _eventDao.getAllEventsFromCalendar(calendarId);
    return EventMapper.listFromDB(entries);
  }

  @override
  Future<void> createOrUpdateEventUpdateInfoList(List<EventUpdateInfo> events) async {
    return _updateInfoDao.upsert(EventUpdateInfoMapper.listToDB(events));
  }

  @override
  Future<void> createOrUpdateCalendar(Calendar calendar) {
    return _calendarDao.createOrUpdateCalendar(CalendarMapper.toDB(calendar: calendar));
  }
}
