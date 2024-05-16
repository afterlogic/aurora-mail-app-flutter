import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event_base.dart';

class EventMapper {
  static List<EventBase> listOfBaseFromNetworkMap(Map<String, dynamic> map,
      {required int userLocalId, required String calendarId}) {
    final List<EventBase> result = [];
    for (final entry in map.entries) {
      final status = UpdateStatusX.fromApiString(entry.key);
      if (status == null) continue;
      result.addAll((entry.value as List).map((e) => EventBase(
          uid: e as String,
          updateStatus: status,
          userLocalId: userLocalId,
          calendarId: calendarId)));
    }
    return result;
  }

  static List<List<Event>> groupEventsByCalendarId(List<Event> models) {
    Map<String, List<Event>> groupedMap = {};

    for (final Event model in models) {
      if (!groupedMap.containsKey(model.calendarId)) {
        groupedMap[model.calendarId] = [];
      }
      groupedMap[model.calendarId]!.add(model);
    }

    return groupedMap.values.toList();
  }
}
