import 'dart:async';

import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
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
    List<Event> notUpdatedEvents =
        await _db.getNotUpdatedEvents(offset: currentOffset, limit: step);
    await _db.deleteMarkedEvents();
    while (notUpdatedEvents.isNotEmpty) {
      logger.log(
          'CURRENT SYNCiNG EVENTS: ${notUpdatedEvents.map((e) => e.uid).toList()}');
      final groupedEvents =
          EventMapper.groupEventsByCalendarId(notUpdatedEvents);
      for (final group in groupedEvents) {
        try {
          final syncedEvents = await _network.updateEvents(group);

          logger.log('SYNCED EVENTS: $syncedEvents');

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
    logger.log('LOCAL CALENDARS: ${localCalendars.map((e) => e.id).toList()}');
    final localCalendarsMap =
        CalendarMapper.convertListToMapById(localCalendars);

    await _db.clearEvents(localCalendars);

    final List<Calendar> calendarsForUpdate = [];
    try {
      final serverCalendarsMap = CalendarMapper.convertListToMapById(
          await _network.getCalendars(user.localId!));
      for (final serverEntry in serverCalendarsMap.entries) {
        if (serverEntry.value.syncToken ==
            localCalendarsMap[serverEntry.key]?.syncToken) continue;
        calendarsForUpdate.add(serverEntry.value);
      }
      logger.log(
          'CALENDARS FOR UPDATE/DOWNLOAD: ${calendarsForUpdate.map((e) => e.id).toList()}');
      final localCalendarsForDeleting = localCalendarsMap.values
          .where((e) => !serverCalendarsMap.containsKey(e.id))
          .toList();
      logger.log(
          'CALENDARS FOR DELETING: ${localCalendarsForDeleting.map((e) => e.id).toList()}');

      await _db.deleteCalendars(localCalendarsForDeleting);

      for (final calendar in calendarsForUpdate) {
        int currentSync =
            int.parse(localCalendarsMap[calendar.id]?.syncToken ?? '0');
        while (currentSync < int.parse(calendar.syncToken)) {
          logger.log('IN ${calendar.id} SYNC: $currentSync');
          final changes = await _network.getChangesForCalendar(
              userLocalId: user.localId!,
              calendarId: calendar.id,
              syncTokenFrom: currentSync);
          logger.log('CHANGES ${changes.map((e) => e.uid)} ');
          await _db.emitChanges(changes);
          currentSync += BATCH_SIZE;
        }
        await _db.createOrUpdateCalendar(calendar);
      }
      await _syncEvents();
    } catch (e) {
      logger.log('CALENDARS SYNC ERROR: $e');
      rethrow;
    }
  }

  @override
  Future<List<Event>> getForPeriod(
      {required DateTime start, required DateTime end}) {
    return _db.getEventsForPeriod(
        start: start, end: end, userLocalId: user.localId!);
  }

  @override
  Future<Calendar> createCalendar(CalendarCreationData data) async {
    final calendarCreationResult = await _network.createCalendar(
        name: data.title,
        color: data.color.toHex(),
        description: data.description,
        userLocalId: user.localId!
    );
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
}
