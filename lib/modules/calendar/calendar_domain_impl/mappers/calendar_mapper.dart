import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';

class CalendarMapper {
  static Calendar fromDB(CalendarDb c) {
    return Calendar(
      color: c.color,
      uuid: c.uuid,
      name: c.name,
      description: c.description,
    );
  }

  static List<Calendar> listFromDB(List<CalendarDb> dbEntries) {
    return dbEntries.map(fromDB).toList();
  }

  static CalendarDb toDB(
      {required Calendar calendar, required int userLocalId}) {
    return CalendarDb(
      color: calendar.color,
      uuid: calendar.uuid,
      name: calendar.name,
      description: calendar.description,
      userLocalId: userLocalId,
    );
  }

  static List<CalendarDb> listToDB(
      {required List<Calendar> calendars, required int userLocalId}) {
    return calendars.map((e) {
      return toDB(calendar: e, userLocalId: userLocalId);
    }).toList();
  }

  static Calendar fromNetwork(Map<String, dynamic> map) {
    return Calendar(
      uuid: map['uuid'] as String,
      color: map['color'] as String,
      description: map['description'] as String?,
      name: map['name'] as String,
    );
  }

  static List<Calendar> listFromNetwork(List<dynamic> rawItems) {
    return rawItems.map((e) => fromNetwork(e as Map<String, dynamic>)).toList();
  }

  static Map<String, dynamic> toNetwork(Calendar c) {
    return {
      'uuid': c.uuid,
      'color': c.color,
      'description': c.description,
      'name': c.name,
    };
  }

}
