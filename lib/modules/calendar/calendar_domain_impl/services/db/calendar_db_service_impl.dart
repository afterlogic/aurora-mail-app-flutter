import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/filters.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/calendar_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/event_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar/calendar_dao.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar_db_service.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/activity/activity_dao.dart';
import 'package:aurora_mail/modules/calendar/utils/recurrence_handlers.dart';
import 'package:collection/collection.dart';

class CalendarDbServiceImpl implements CalendarDbService {
  CalendarDbServiceImpl(AppDatabase db)
      : _calendarDao = CalendarDao(db),
        _activityDao = ActivityDao(db);

  final CalendarDao _calendarDao;
  final ActivityDao _activityDao;

  @override
  Future<List<Calendar>> getCalendars(int userLocalId) async {
    final entries = await _calendarDao.getAllCalendars(userLocalId);
    return CalendarMapper.listFromDB(entries);
  }

  @override
  Future<void> emitChanges(List<ActivityBase> events) async {
    return _activityDao.syncEventList(events.map((e) => e.toDb()).toList());
  }

  @override
  Future<void> createOrUpdateCalendar(Calendar calendar) {
    final calendarForSaving = calendar.copyWith(
        shares: calendar.shares..removeWhere((e) => e is ParticipantAll));
    return _calendarDao.createOrUpdateCalendar(
        CalendarMapper.toDB(calendar: calendarForSaving));
  }

  @override
  Future<void> deleteCalendars(List<Calendar> calendars) async {
    await _calendarDao.deleteCalendars(calendars.map((e) => e.id).toList());
    for (final c in calendars) {
      logger.log('DELETING CALENDAR: ${c.id}');
      await _activityDao.deleteAllEventsFromCalendar(c.id, c.userLocalId);
    }
  }

  /// all events that not contain id from [calendars] will be deleted
  @override
  Future<void> clearEvents(List<Calendar> calendars) async {
    final calendarIds = calendars.map((e) => e.id).toList();
    final userIds = calendars.map((e) => e.userLocalId).toList();
    final affectedRowsCount =
        await _activityDao.deleteAllUnusedEvents(calendarIds, userIds);
    logger.log('DELETED UNUSED EVENTS COUNT: $affectedRowsCount');
  }

  @override
  Future<void> updateEventList(List<Activity> events) {
    return _activityDao.syncEventList(events.map((e) => e.toDb()).toList(),
        synced: true);
  }

  @override
  Future<void> deleteMarkedEvents() async {
    final deletedCount = await _activityDao.deleteMarkedEvents();
    logger.log('DELETED $deletedCount EVENTS MARKED AS DELETED: ');
  }

  @override
  Future<List<ActivityBase>> getNotUpdatedEvents(
      {required int? limit, required int? offset}) async {
    final result =
        await _activityDao.getEventsWithLimit(limit: limit, offset: offset);
    return result
        .map((e) => e.toActivity())
        .whereNotNull()
        .where((e) => !e.synced)
        .toList();
  }

  @override
  Future<List<Activity>> getActivitiesForPeriod(
      {required DateTime start,
      required DateTime end,
      ActivityType? type,
      required List<String> calendarIds,
      required int userLocalId}) async {
    final entities = await _activityDao.getForPeriod(
        calendarIds: calendarIds,
        start: start,
        end: end,
        userLocalId: userLocalId);
    final models = entities.map((e) => e.toActivity()).whereType<Activity>().toList();
    final recurrenceModels = models.where((e) => e.recurrenceMode != RecurrenceMode.never).toList();
    final withoutRecurrenceModels = models.where((e) => e.recurrenceMode == RecurrenceMode.never).toList();
    final recurrenceHandledModels = handleRecurrence(start, end, recurrenceModels);

    return [...withoutRecurrenceModels, ...recurrenceHandledModels];
  }

  @override
  Future<List<Activity>> getActivities(
      {required List<String>? calendarIds,
      required ActivityFilter filter,
      ActivityType? type,
      required int userLocalId}) async {
    final entities = await _activityDao.getAll(
        filter: filter,
        calendarIds: calendarIds,
        type: type,
        userLocalId: userLocalId);
    return entities.map((e) => e.toActivity()).whereType<Activity>().toList();
  }

  @override
  Future<void> clearData() async {
    await _calendarDao.deleteAllCalendars();
    await _activityDao.deleteAllEvents();
  }

  @override
  Future<Activity> getActivityByUid({required String calendarId, required String activityUid, required int userLocalId}) async {
    final entity = await _activityDao.getByUid(calendarId: calendarId, userLocalId: userLocalId, uid: activityUid, );
    final model  = entity.toActivity();
    if ((model is! Activity)) throw Exception('Activity not synced');
    return model;
  }
}
