import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:equatable/equatable.dart';
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
  final bool isSubscribed;
  // final List shares;
  final String syncToken;
  // same with iCal URL
  final String source;

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
    required this.isSubscribed,
    required this.source,
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
      syncToken: syncToken,
      isSubscribed: isSubscribed,
      source: source,
    );
  }

  bool isUserOwner(User user) {
    return user.emailFromLogin == owner;
  }

  bool areFieldsChanged(Calendar comparable) {
    return comparable.sharedToAll != sharedToAll ||
        comparable.sharedToAllAccess != sharedToAllAccess ||
        comparable.access != access ||
        comparable.shared != shared;
  }

  @override
  String toString() {
    return '${name}, ID: ${id}, sync token: ${syncToken}';
  }

  Calendar copyWith({
    String? id,
    int? userLocalId,
    Color? color,
    String? Function()? description,
    String? name,
    String? owner,
    bool? isDefault,
    bool? shared,
    bool? sharedToAll,
    int? sharedToAllAccess,
    int? access,
    bool? isPublic,
    bool? isSubscribed,
    String? source,
    List? shares,
    String? syncToken,
  }) {
    return Calendar(
      id: id ?? this.id,
      userLocalId: userLocalId ?? this.userLocalId,
      color: color ?? this.color,
      description: description == null ? this.description : description(),
      name: name ?? this.name,
      owner: owner ?? this.owner,
      isDefault: isDefault ?? this.isDefault,
      shared: shared ?? this.shared,
      sharedToAll: sharedToAll ?? this.sharedToAll,
      sharedToAllAccess: sharedToAllAccess ?? this.sharedToAllAccess,
      access: access ?? this.access,
      isPublic: isPublic ?? this.isPublic,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      source: source ?? this.source,
      // shares: shares ?? this.shares,
      syncToken: syncToken ?? this.syncToken,
    );
  }
}

class CalendarCreationData {
  final String title;
  final String? description;
  final Color color;
  final String? iCalMail;

  const CalendarCreationData(
      {required this.title,
      this.description,
      required this.color,
      this.iCalMail});
}

class Participant extends Equatable{
  final String email;
  final String name;
  final ParticipantPermissions permissions;

  const Participant(
      {required this.email, required this.permissions, required this.name});

  Participant copyWith({ParticipantPermissions? permissions}) {
    return Participant(
        email: email, name: name, permissions: permissions ?? this.permissions);
  }

  @override
  List<Object?> get props => [email, name];
}

enum ParticipantPermissions { read, readWrite }
