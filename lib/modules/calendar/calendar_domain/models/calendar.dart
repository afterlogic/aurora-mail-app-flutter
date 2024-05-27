import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:flutter/material.dart';

class Calendar {
  final String id;
  final int userLocalId;
  final Color color;
  final String? description;
  final String name;
  final String owner;
  final bool isDefault;
  final bool shared;
  final bool sharedToAll;
  final int sharedToAllAccess;
  final int access;
  final bool isPublic;
  // final List shares;
  final String syncToken;

  const Calendar({
    required this.id,
    required this.userLocalId,
    required this.color,
    this.description,
    required this.name,
    required this.owner,
    required this.isDefault,
    required this.shared,
    required this.sharedToAll,
    required this.sharedToAllAccess,
    required this.access,
    required this.isPublic,
    // required this.shares,
    required this.syncToken,
  });

  ViewCalendar toViewCalendar() {
    return ViewCalendar(
        id: id,
        userLocalId: userLocalId,
        color: color,
        name: name,
        owner: owner,
        isDefault: isDefault,
        shared: shared,
        sharedToAll: sharedToAll,
        sharedToAllAccess: sharedToAllAccess,
        access: access,
        isPublic: isPublic,
        description: description,
        syncToken: syncToken);
  }


  @override
  String toString() {
    return 'Calendar{' +
        ' id: $id,' +
        ' userLocalId: $userLocalId,' +
        ' color: $color,' +
        ' description: $description,' +
        ' name: $name,' +
        ' owner: $owner,' +
        ' isDefault: $isDefault,' +
        ' shared: $shared,' +
        ' sharedToAll: $sharedToAll,' +
        ' sharedToAllAccess: $sharedToAllAccess,' +
        ' access: $access,' +
        ' isPublic: $isPublic,' +
        // ' shares: $shares,' +
        ' syncToken: $syncToken,' +
        '}';
  }

  Calendar copyWith({
    String? id,
    int? userLocalId,
    Color? color,
    String? description,
    String? name,
    String? owner,
    bool? isDefault,
    bool? shared,
    bool? sharedToAll,
    int? sharedToAllAccess,
    int? access,
    bool? isPublic,
    List? shares,
    String? syncToken,
  }) {
    return Calendar(
      id: id ?? this.id,
      userLocalId: userLocalId ?? this.userLocalId,
      color: color ?? this.color,
      description: description ?? this.description,
      name: name ?? this.name,
      owner: owner ?? this.owner,
      isDefault: isDefault ?? this.isDefault,
      shared: shared ?? this.shared,
      sharedToAll: sharedToAll ?? this.sharedToAll,
      sharedToAllAccess: sharedToAllAccess ?? this.sharedToAllAccess,
      access: access ?? this.access,
      isPublic: isPublic ?? this.isPublic,
      // shares: shares ?? this.shares,
      syncToken: syncToken ?? this.syncToken,
    );
  }
}

class CalendarCreationData {
  final String title;
  final String description;
  final Color color;
  final String? iCalMail;

  const CalendarCreationData(
      {required this.title,
      required this.description,
      required this.color,
      this.iCalMail});
}
