import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';

class EventMapper {
  static Event fromDB(EventDb e) {
    return Event(
      name: e.name,
      description: e.description,
      localId: e.localId,
      calendarId: e.calendarId,
      startTS: e.startTS,
      isAllDay: e.isAllDay,
    );
  }

  static List<Event> listFromDB(List<EventDb> dbEntries) {
    return dbEntries.map(fromDB).toList();
  }

  static EventDb toDB({required Event event, required int userLocalId}) {
    return EventDb(
      name: event.name,
      description: event.description,
      userLocalId: userLocalId,
      localId: event.localId,
      calendarId: event.calendarId,
      startTS: event.startTS,
      endTS: event.endTS,
      isAllDay: event.isAllDay,
    );
  }

  static List<EventDb> listToDB(
      {required List<Event> calendars, required int userLocalId}) {
    return calendars.map((e) {
      return toDB(event: e, userLocalId: userLocalId);
    }).toList();
  }

  static Event fromNetwork(Map<String, dynamic> map) {
    return Event(
      localId: map['localId'] as int,
      calendarId: map['calendarId'] as String,
      startTS:  DateTime.fromMillisecondsSinceEpoch((map['startTS'] as int) * 1000),
      endTS: (map['endTS'] as int?) == null ? null : DateTime.fromMillisecondsSinceEpoch((map['endTS'] as int) * 1000) ,
      description: map['description'] as String,
      name: map['name'] as String,
      isAllDay: map['isAllDay'] as bool,
    );
  }

  static List<Event> listFromNetwork(List<dynamic> rawItems) {
    return rawItems.map((e) => fromNetwork(e as Map<String, dynamic>)).toList();
  }

  static Map<String, dynamic> toNetwork(Event e) {
    return {
      'localId': e.localId,
      'calendarId': e.calendarId,
      'startTS': e.startTS.toUtc().millisecondsSinceEpoch ~/ 1000,
      'endTS': e.endTS == null ? null : e.endTS!.toUtc().millisecondsSinceEpoch ~/ 1000,
      'description': e.description,
      'name': e.name,
      'isAllDay': e.isAllDay,
    };
  }
}
