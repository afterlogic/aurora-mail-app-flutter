import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/calendar_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/event_update_info_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar_db_service.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/event/event_update_info.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/network/calendar_network_service.dart';
import 'package:aurora_mail/modules/settings/screens/debug/default_api_interceptor.dart';
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
    List<EventUpdateInfo> updateInfo = await _db.getEventUpdateInfoList();
    //TODO instead of WHILE get all ids from db
    while (updateInfo.isNotEmpty) {
      final groupedUpdateInfo =
          EventUpdateInfoMapper.groupByCalendarId(updateInfo);
      for (final group in groupedUpdateInfo) {
        try {
          final events = await _network.getEvents(
              uuids: group
                  .where((e) => !e.updateStatus.isDeleted)
                  .map((e) => e.uid)
                  .toList(),
              userId: group.first.userLocalId,
              calendarId: group.first.calendarId);
          await _db.createOrUpdateEventList(events);
          await _db.deleteEventsByInfo(
              group.where((e) => e.updateStatus.isDeleted).toList());
          await _db.deleteEventUpdateInfoList(group);
        } catch (e) {
          rethrow;
        }
      }
      updateInfo = await _db.getEventUpdateInfoList();
    }
  }

  @override
  Future<void> syncCalendars() async {
    final localCalendars = await _db.getCalendars(user.localId!);
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
      final localCalendarsForDeleting = localCalendarsMap.values
          .where((e) => !serverCalendarsMap.containsKey(e.id))
          .toList();
      await _db.deleteCalendars(localCalendarsForDeleting);

      await _syncEvents();

      for (final calendar in calendarsForUpdate) {
        int currentSync =
            int.parse(localCalendarsMap[calendar.id]?.syncToken ?? '0');
        while (currentSync < int.parse(calendar.syncToken)) {
          final changes = await _network.getChangesForCalendar(
              userLocalId: user.localId!,
              calendarId: calendar.id,
              syncTokenFrom: currentSync);
          await _db.createOrUpdateEventUpdateInfoList(changes);
          currentSync += BATCH_SIZE;
        }
        await _db.createOrUpdateCalendar(calendar);
      }

      await _syncEvents();
    } catch (e) {
      print(e);
    }
  }
}
