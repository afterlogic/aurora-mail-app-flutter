import 'dart:async';

import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/filters.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/reminders_option.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/task.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/calendar_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/event_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar_db_service.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/network/calendar_network_service.dart';
import 'package:aurora_mail/modules/settings/screens/debug/default_api_interceptor.dart';
import 'package:aurora_mail/utils/extensions/colors_extensions.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  static const int BATCH_SIZE = 50;

  final User user;
  late final CalendarNetworkService _network;
  late final CalendarDbService _db;

  CalendarRepositoryImpl({
    required this.user,
    required AppDatabase appDB,
  }) {
    final module = new WebMailApi(
      moduleName: WebMailModules.calendar,
      hostname: user.hostname,
      token: user.token,
      interceptor: DefaultApiInterceptor.get(),
    );

    _network = new CalendarNetworkService(module, user.serverId);
    _db = new CalendarDbService(appDB);
  }

  Future<void> _syncEvents() async {
    final int step = 20;
    int currentOffset = 0;
    List<ActivityBase> notUpdatedEvents =
        await _db.getNotUpdatedEvents(offset: null, limit: null);
    await _db.deleteMarkedEvents();
    while (notUpdatedEvents.isNotEmpty) {
      logger.log(
          'CURRENT EVENTS INFO FOR SYNC: ${notUpdatedEvents.map((e) => '${e.uid} : ${e.updateStatus.name}').toList()}');
      final groupedEvents =
          EventMapper.groupEventsByCalendarId(notUpdatedEvents);
      for (final group in groupedEvents) {
        try {
          final syncedEvents = await _network.updateActivities(group);
          logger.log('EVENTS FROM SERVER: $syncedEvents');
          await _db.updateEventList(syncedEvents);
        } catch (e) {
          rethrow;
        }
      }
      currentOffset += step;
      notUpdatedEvents =
          await _db.getNotUpdatedEvents(offset: currentOffset, limit: step);
    }
  }

  @override
  Future<void> syncCalendars() async {
    final localCalendars = await _db.getCalendars(user.localId!);
    logger.log(
        'LOCAL CALENDARS: ${localCalendars.map((e) => e.toString()).toList()}');
    final localCalendarsMap =
    CalendarMapper.convertListToMapById(localCalendars);

    final List<Calendar> calendarsForDownload = [];
    try {
      final calendarsFromServer = await _network.getCalendars(user.localId!);
      logger.log(
          'CALENDARS FROM SERVER: ${calendarsFromServer.map((e) => e.toString()).toList()}');
      final serverCalendarsMap =
      CalendarMapper.convertListToMapById(calendarsFromServer);
      for (final serverEntry in serverCalendarsMap.entries) {
        if (localCalendarsMap.containsKey(serverEntry.key)) continue;
        calendarsForDownload.add(serverEntry.value.copyWith(syncToken: '1'));
      }
      logger.log(
          'CALENDARS FOR DOWNLOAD: ${calendarsForDownload.map((e) => e.toString()).toList()}');
      final localCalendarsForDeleting = localCalendarsMap.values
          .where((e) => !serverCalendarsMap.containsKey(e.id))
          .toList();
      logger.log(
          'CALENDARS FOR DELETING: ${localCalendarsForDeleting.map((e) => e.toString()).toList()}');

      await _db.deleteCalendars(localCalendarsForDeleting);

      for (final calendar in calendarsForDownload) {
        await _db.createOrUpdateCalendar(calendar);
      }
    } catch (e, st) {
      logger.log('CALENDARS SYNC ERROR: $e');
      rethrow;
    }
  }

  @override
  Future<void> syncCalendarsWithActivities() async {
    final localCalendars = await _db.getCalendars(user.localId!);
    logger.log(
        'LOCAL CALENDARS: ${localCalendars.map((e) => e.toString()).toList()}');
    final localCalendarsMap =
        CalendarMapper.convertListToMapById(localCalendars);

    await _db.clearEvents(localCalendars);

    final List<Calendar> calendarsForUpdate = [];
    try {
      final calendarsFromServer = await _network.getCalendars(user.localId!);
      logger.log(
          'CALENDARS FROM SERVER: ${calendarsFromServer.map((e) => e.toString()).toList()}');
      final serverCalendarsMap =
          CalendarMapper.convertListToMapById(calendarsFromServer);
      for (final serverEntry in serverCalendarsMap.entries) {
        if (serverEntry.value.syncToken ==
                localCalendarsMap[serverEntry.key]?.syncToken &&
            localCalendarsMap[serverEntry.key]
                    ?.areFieldsChanged(serverEntry.value) ==
                false) continue;
        calendarsForUpdate.add(serverEntry.value);
      }
      logger.log(
          'CALENDARS FOR UPDATE/DOWNLOAD: ${calendarsForUpdate.map((e) => e.toString()).toList()}');
      final localCalendarsForDeleting = localCalendarsMap.values
          .where((e) => !serverCalendarsMap.containsKey(e.id))
          .toList();
      logger.log(
          'CALENDARS FOR DELETING: ${localCalendarsForDeleting.map((e) => e.toString()).toList()}');

      await _db.deleteCalendars(localCalendarsForDeleting);

      for (final calendar in calendarsForUpdate) {
        int currentSync =
            int.parse(localCalendarsMap[calendar.id]?.syncToken ?? '0');
        logger.log(
            'IN ${calendar.id} INITIAL SYNC: $currentSync, TARGET SYNC: ${calendar.syncToken}');
        while (currentSync < int.parse(calendar.syncToken)) {
          logger.log('IN ${calendar.id} SYNC: $currentSync');
          final changes = await _network.getChangesForCalendar(
              userLocalId: user.localId!,
              calendarId: calendar.id,
              syncTokenFrom: currentSync);
          logger.log(
              'FOR ${calendar.id} AND SYNC = $currentSync CHANGES: ${changes.map((e) => e.toString())} ');
          await _db.emitChanges(changes);
          currentSync += BATCH_SIZE;
          if (currentSync > int.parse(calendar.syncToken)) {
            currentSync = int.parse(calendar.syncToken);
          }
        }
        await _db.createOrUpdateCalendar(calendar);
      }
      await _syncEvents();
    } catch (e, st) {
      logger.log('CALENDARS SYNC ERROR: $e');
      rethrow;
    }
  }

  @override
  Future<List<Event>> getEventsForPeriod(
      {required DateTime start,
      required DateTime end,
      required List<String> calendarIds}) async {
    final activities = await _db.getActivitiesForPeriod(
        start: start,
        end: end,
        userLocalId: user.localId!,
        calendarIds: calendarIds);
    return activities.whereType<Event>().toList();
  }

  @override
  Future<List<Task>> getTasks(ActivityFilter filter) async {
    final activities = await _db.getActivities(
        filter: filter,
        userLocalId: user.localId!,
        type: ActivityType.task,
        calendarIds: null);
    return activities.whereType<Task>().toList();
  }

  @override
  Future<Calendar> createCalendar(CalendarCreationData data) async {
    final calendarCreationResult = await _network.createCalendar(
        name: data.title,
        color: data.color.toHex(),
        description: data.description,
        userLocalId: user.localId!);
    await _db.createOrUpdateCalendar(calendarCreationResult);
    return calendarCreationResult;
  }

  @override
  Future<List<Calendar>> getCalendars() {
    return _db.getCalendars(user.localId!);
  }

  @override
  Future<void> deleteCalendar(Calendar calendar) async {
    await _network.deleteCalendar(id: calendar.id);
    await _db.deleteCalendars([calendar]);
  }

  @override
  Future<void> unsubscribeFromCalendar(Calendar calendar) async {
    await _network.deleteCalendar(id: calendar.id);
    await _db.deleteCalendars([calendar]);
  }

  @override
  Future<void> updateCalendar(Calendar calendar) async {
    final isUpdated = await _network.updateCalendar(
        id: calendar.id,
        name: calendar.name,
        description: calendar.description ?? '',
        color: calendar.color.toHex());
    if (!isUpdated) throw Exception('Error while updating calendar');
    await _db.createOrUpdateCalendar(calendar);
  }

  @override
  Future<void> updateCalendarPublic(Calendar calendar) async {
    final isUpdated = await _network.updateCalendarPublic(
        calendarId: calendar.id, isPublic: calendar.isPublic);
    if (!isUpdated)
      throw Exception('Error while changing calendar public status');
    await _db.createOrUpdateCalendar(calendar);
  }

  @override
  Future<void> updateCalendarSharing(Calendar calendar) async {
    final isUpdated = await _network.updateSharing(
        calendarId: calendar.id, participants: calendar.shares.toList());
    if (!isUpdated) throw Exception('Error while changing calendar shares');
    await _db.createOrUpdateCalendar(calendar);
  }

  @override
  Future<void> createActivity(ActivityCreationData data) {
    return _network.createActivity(creationData: data);
  }

  @override
  Future<Activity> updateActivity(Activity activity) {
    return _network.updateActivity(activity);
  }

  @override
  Future<void> deleteActivity(Activity activity) {
    return _network.deleteActivity(activity);
  }

  @override
  Future<void> clearData() async {
    await _db.clearData();
  }

  @override
  Future<Activity> getActivityByUid({required String calendarId, required String activityUid}) {
    return _db.getActivityByUid(userLocalId: user.localId!, calendarId: calendarId, activityUid: activityUid);
  }
}
