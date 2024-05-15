import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';

class EventMapper {
  static Event fromDB(EventDb e) {
    return Event(
        description: e.description,
        calendarId: e.calendarId,
        userLocalId: e.userLocalId,
        startTS: e.startTS,
        organizer: e.organizer,
        appointment: e.appointment,
        appointmentAccess: e.appointmentAccess,
        id: e.id,
        uid: e.uid,
        allDay: e.allDay,
        owner: e.owner,
        modified: e.modified,
        recurrenceId: e.recurrenceId,
        lastModified: e.lastModified,
        status: e.status,
        withDate: e.withDate,
        isPrivate: e.isPrivate,
        rrule: null,
        subject: e.subject,
        endTS: e.endTS);
  }

  static List<Event> listFromDB(List<EventDb> dbEntries) {
    return dbEntries.map(fromDB).toList();
  }

  static EventDb toDB({required Event event}) {
    return EventDb(
        description: event.description,
        calendarId: event.calendarId,
        startTS: event.startTS,
        organizer: event.organizer,
        appointment: event.appointment,
        appointmentAccess: event.appointmentAccess,
        id: event.id,
        userLocalId: event.userLocalId,
        uid: event.uid,
        allDay: event.allDay,
        owner: event.owner,
        modified: event.modified,
        recurrenceId: event.recurrenceId,
        lastModified: event.lastModified,
        status: event.status,
        withDate: event.withDate,
        isPrivate: event.isPrivate,
        // rrule: null,
        subject: event.subject,
        endTS: event.endTS);
  }

  static List<EventDb> listToDB(
      {required List<Event> events}) {
    return events.map((e) {
      return toDB(event: e);
    }).toList();
  }

  static Event fromNetwork(Map<String, dynamic> map, {required int userLocalId}) {
    return Event(
      organizer: map['organizer'] as String? ?? '',
      appointment: (map['appointment'] as bool?)!,
      appointmentAccess: (map['appointmentAccess'] as int?)!,
      calendarId: (map['calendarId'] as String?)!,
      id: (map['id'] as String?)!,
      userLocalId: userLocalId,
      uid: (map['uid'] as String?)!,
      subject: (map['subject'] as String?)!,
      description: (map['description'] as String?)!,
      startTS:
          DateTime.fromMillisecondsSinceEpoch((map['startTS'] as int?) ?? 100000 * 1000),
      endTS: (map['endTS'] as int?) == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch((map['endTS'] as int) * 1000),
      allDay: (map['allDay'] as bool?)!,
      owner: (map['owner'] as String?)!,
      modified: (map['modified'] as bool?)!,
      recurrenceId: (map['recurrenceId'] as int?)!,
      lastModified: (map['lastModified'] as int?)!,
      rrule: null,
      status: (map['status'] as bool?)!,
      withDate: (map['withDate'] as bool?)!,
      isPrivate: (map['isPrivate'] as bool?)!,
    );
  }

  static List<Event> listFromNetwork(List<dynamic> rawItems, {required int userLocalId}) {
    return rawItems.map((e) => fromNetwork(e as Map<String, dynamic>, userLocalId: userLocalId)).toList();
  }

  static Map<String, dynamic> toNetwork(Event e) {
    return {
      'organizer': e.organizer,
      'appointment': e.appointment,
      'appointmentAccess': e.appointmentAccess,
      'calendarId': e.calendarId,
      'id': e.id,
      'uid': e.uid,
      'subject': e.subject,
      'description': e.description,
      'startTS': e.startTS.toUtc().millisecondsSinceEpoch ~/ 1000,
      'endTS': e.endTS == null
          ? null
          : e.endTS!.toUtc().millisecondsSinceEpoch ~/ 1000,
      'allDay': e.allDay,
      'owner': e.owner,
      'modified': e.modified,
      'recurrenceId': e.recurrenceId,
      'lastModified': e.lastModified,
      'rrule': e.rrule,
      'status': e.status,
      'withDate': e.withDate,
      'isPrivate': e.isPrivate,
    };
  }
}
