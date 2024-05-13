import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';

class CalendarMapper {
  static Calendar fromDB(CalendarDb c) {
    return Calendar(
      color: c.color,
      name: c.name,
      description: c.description,
      id: c.id,
      owner: c.owner,
      isDefault: c.isDefault,
      shared: c.shared,
      sharedToAll: c.sharedToAll,
      sharedToAllAccess: c.sharedToAllAccess,
      access: c.access,
      isPublic: c.isPublic,
      syncToken: c.syncToken,
    );
  }

  static List<Calendar> listFromDB(List<CalendarDb> dbEntries) {
    return dbEntries.map(fromDB).toList();
  }

  static CalendarDb toDB(
      {required Calendar calendar, required int userLocalId}) {
    return CalendarDb(
      color: calendar.color,
      name: calendar.name,
      description: calendar.description,
      id: calendar.id,
      owner: calendar.owner,
      isDefault: calendar.isDefault,
      shared: calendar.shared,
      sharedToAll: calendar.sharedToAll,
      sharedToAllAccess: calendar.sharedToAllAccess,
      access: calendar.access,
      isPublic: calendar.isPublic,
      syncToken: calendar.syncToken,
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
      id:(map['Id'] as String?)!,
      color: (map['Color'] as String?)!,
      description:map['Description'] as String?,
      name:(map['Name'] as String?)!,
      owner:(map['Owner'] as String?)!,
      isDefault:(map['IsDefault'] as bool?)!,
      shared:(map['Shared'] as bool?)!,
      sharedToAll:(map['SharedToAll'] as bool?)!,
      sharedToAllAccess:(map['SharedToAllAccess'] as int?)!,
      access:(map['Access'] as int?)!,
      isPublic:(map['IsPublic'] as bool?)!,
      // shares:(map['shares'] as List?)!,
      syncToken:(map['SyncToken'] as String?)!,
    );
  }

  static List<Calendar> listFromNetwork(List<dynamic> rawItems) {
    return rawItems.map((e) => fromNetwork(e as Map<String, dynamic>)).toList();
  }

  static Map<String, dynamic> toNetwork(Calendar c) {
    return {
      'id': c.id,
      'color': c.color,
      'description': c.description,
      'name': c.name,
      'owner': c.owner,
      'isDefault': c.isDefault,
      'shared': c.shared,
      'sharedToAll': c.sharedToAll,
      'sharedToAllAccess': c.sharedToAllAccess,
      'access': c.access,
      'isPublic': c.isPublic,
      // 'shares': c.shares,
      'syncToken': c.syncToken,
    };
  }

  static Map<String, Calendar> convertListToMapById(List<Calendar> calendars) {
    Map<String, Calendar> resultMap = {};

    calendars.forEach((calendar) {
      resultMap[calendar.id] = calendar;
    });

    return resultMap;
  }
}
