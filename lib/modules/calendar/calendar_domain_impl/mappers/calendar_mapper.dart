import 'dart:convert';

import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/utils/extensions/colors_extensions.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:flutter/material.dart';

class CalendarMapper {
  static Calendar fromDB(CalendarDb c) {
    return Calendar(
        color: HexColor.fromHex(c.color),
        name: c.name,
        description: c.description,
        id: c.id,
        userLocalId: c.userLocalId,
        owner: c.owner,
        isDefault: c.isDefault,
        shared: c.shared,
        sharedToAll: c.sharedToAll,
        sharedToAllAccess: c.sharedToAllAccess,
        access: c.access,
        isPublic: c.isPublic,
        source: c.source,
        syncToken: c.syncToken,
        isSubscribed: c.isSubscribed,
        serverUrl: c.serverUrl,
        url: c.url,
        exportHash: c.exportHash,
        pubHash: c.pubHash,
        shares: c.shares
                ?.map((e) =>
                    Participant.fromMap(jsonDecode(e) as Map<String, dynamic>))
                .toSet() ??
            {});
  }

  static List<Calendar> listFromDB(List<CalendarDb> dbEntries) {
    return dbEntries.map(fromDB).toList();
  }

  static CalendarDb toDB({required Calendar calendar}) {
    return CalendarDb(
      color: calendar.color.toHex(),
      name: calendar.name,
      description: calendar.description,
      id: calendar.id,
      userLocalId: calendar.userLocalId,
      owner: calendar.owner,
      isDefault: calendar.isDefault,
      shared: calendar.shared,
      sharedToAll: calendar.sharedToAll,
      sharedToAllAccess: calendar.sharedToAllAccess,
      access: calendar.access,
      isPublic: calendar.isPublic,
      isSubscribed: calendar.isSubscribed,
      source: calendar.source,
      syncToken: calendar.syncToken,
        shares: calendar.shares.map((e) => jsonEncode(e.toMap())).toList(),
      url: calendar.url,
      serverUrl: calendar.serverUrl,
      exportHash: calendar.exportHash,
      pubHash: calendar.pubHash,
    );
  }

  static List<CalendarDb> listToDB({required List<Calendar> calendars}) {
    return calendars.map((e) {
      return toDB(calendar: e);
    }).toList();
  }

  static Calendar fromNetwork(Map<String, dynamic> map,
      {required int userLocalId, required String serverUrl}) {
    final syncToken = (map['SyncToken'] as String?)!;
    if (syncToken.isEmpty) throw Exception('SyncToken is empty');
    return Calendar(
      id: (map['Id'] as String?)!,
      userLocalId: userLocalId,
      color: HexColor.fromHex((map['Color'] as String?)!),
      description: map['Description'] as String?,
      name: (map['Name'] as String?)!,
      owner: (map['Owner'] as String?)!,
      isDefault: (map['IsDefault'] as bool?)!,
      shared: (map['Shared'] as bool?)!,
      sharedToAll: (map['SharedToAll'] as bool?)!,
      sharedToAllAccess: (map['SharedToAllAccess'] as int?)!,
      access: (map['Access'] as int?)!,
      isPublic: (map['IsPublic'] as bool?)!,
      // shares:(map['shares'] as List?)!,
      syncToken: syncToken,
      isSubscribed: (map['IsPublic'] as bool?) ?? false,
      source: (map['Source'] as String?) ?? "",
        shares: (map['Shares'] as List).map((e) => Participant.fromMap(e as Map<String, dynamic>)).toSet(),
        serverUrl: serverUrl,
      url: (map['Url'] as String?)!,
      pubHash: (map['PubHash'] as String?)!,
      exportHash: (map['ExportHash'] as String?)!,

    );
  }

  static List<Calendar> listFromNetwork(List<dynamic> rawItems,
      {required int userLocalId, required String serverUrl}) {
    final List<Calendar> result = [];
    rawItems.forEach((rawItem) {
      try {
        final calendar = fromNetwork(rawItem as Map<String, dynamic>,
            userLocalId: userLocalId, serverUrl: serverUrl);
        result.add(calendar);
      } catch (e, st) {
        logger.log(e);
      }
    });
    return result;
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
