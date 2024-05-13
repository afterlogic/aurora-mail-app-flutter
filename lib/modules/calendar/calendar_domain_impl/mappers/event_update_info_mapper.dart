import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/event/event_update_info.dart';

class EventUpdateInfoMapper{
  static EventUpdateInfo fromDB(EventUpdateInfoDb e) {
    return EventUpdateInfo(
        uid: e.uid,
        updateStatus: e.updateStatus

    );
  }

  static List<EventUpdateInfo> listFromDB(List<EventUpdateInfoDb> dbEntries) {
    return dbEntries.map(fromDB).toList();
  }

  static EventUpdateInfoDb toDB(
       EventUpdateInfo event) {
    return EventUpdateInfoDb(
        uid: event.uid,
        updateStatus: event.updateStatus
    );
  }

  static List<EventUpdateInfoDb> listToDB(List<EventUpdateInfo> events
      ) {
    return events.map(toDB).toList();
  }


  static List<EventUpdateInfo> listFromNetworkMap(Map<String, dynamic> map) {
    final List<EventUpdateInfo> result = [];
    for (final entry in map.entries){
      final status = UpdateStatusX.fromApiString(entry.key);
      if(status == null) continue;
      result.addAll((entry.value as List<String>).map((e) => EventUpdateInfo(uid: e, updateStatus: status)));
    }
    return result;
  }
}