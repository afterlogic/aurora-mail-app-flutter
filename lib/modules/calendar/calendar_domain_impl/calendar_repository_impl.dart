import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/calendar_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar_db_service.dart';
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

  @override
  Future<void> syncCalendars() async {
    //TODO delete local calendars, that deleted globally
    //TODO Download events by existing local event info, then delete local event info
    final localCalendars = CalendarMapper.convertListToMapById(
        await _db.getCalendars(user.localId!));
    final List<Calendar> calendarsForUpdate = [];
    try {
      //TODO delete old calendars with events

      final serverCalendarsMap =
          CalendarMapper.convertListToMapById(await _network.getCalendars());
      for (final serverEntry in serverCalendarsMap.entries) {
        if (serverEntry.value.syncToken ==
            localCalendars[serverEntry.key]?.syncToken) continue;
        calendarsForUpdate.add(serverEntry.value);
      }

      for(final calendar in calendarsForUpdate){
        int currentSync = int.parse(localCalendars[calendar.id]?.syncToken ?? '0');
        while (currentSync < int.parse(calendar.syncToken)){
          final changes = await _network.getChangesForCalendar(calendarId: calendar.id, syncTokenFrom: currentSync);
          await _db.createOrUpdateEventUpdateInfoList(changes);
          currentSync += BATCH_SIZE;

        }
        await _db.createOrUpdateCalendar(calendar);
      }
      // TODO download and save events from changes
    } catch (e) {
      print(e);
    }
  }
}
