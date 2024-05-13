import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/calendar_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/event_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar/calendar_dao.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar_db_service.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/event/event_dao.dart';

class CalendarDbServiceImpl implements CalendarDbService {
  CalendarDbServiceImpl(AppDatabase db)
      : _calendarDao = CalendarDao(db),
        _eventDao = EventDao(db);

  final CalendarDao _calendarDao;
  late final EventDao _eventDao;

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
}
