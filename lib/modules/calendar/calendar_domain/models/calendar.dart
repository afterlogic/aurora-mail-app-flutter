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
  final String serverUrl;
  final String url;
  final String exportHash;
  final String pubHash;
  final Set<Participant> shares;
  final String syncToken;
  // same with iCal URL
  final String source;

  const Calendar({
    required this.id,
    required this.userLocalId,
    required this.color,
    required this.serverUrl,
    required this.url,
    required this.exportHash,
    required this.pubHash,
    required this.shares,
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
      serverUrl: serverUrl,
      url: url,
      exportHash:exportHash,
      pubHash: pubHash,
      shares: shares
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

  String getDownloadUrl(User user) {
    return '${user.hostname}/?calendar-download/$exportHash';
  }

  String getPublicLink(User user) {
    return '${user.hostname}/?calendar-pub=$pubHash';
  }

  String get DAVUrl {
    return serverUrl + url;
  }

  String get ICSUrl {
    return DAVUrl + '?export';
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
    String? syncToken,
    String? serverUrl,
    String? url,
    String? exportHash,
    String? pubHash,
    Set<Participant>? shares,
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
      syncToken: syncToken ?? this.syncToken,
      serverUrl: serverUrl ?? this.serverUrl,
      url: url ?? this.url,
      exportHash: exportHash ?? this.exportHash,
      pubHash: pubHash ?? this.pubHash,
      shares: shares ?? this.shares,
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

  Map<String, dynamic> toMap() {
    return {
      'access': this.permissions.code,
      'email': this.email,
      'name': this.name,
    };
  }

  factory Participant.fromMap(Map<String, dynamic> map) {
    return Participant(
      permissions: ParticipantPermissionsMapper.fromCode(map['access'] as int),
      email: (map['email'] as String?)!,
      name: (map['name'] as String?) ?? '',
    );
  }

  @override
  List<Object?> get props => [email, name, permissions];
}

class ParticipantAll extends Participant{
  static const addAllIdentifier = "add_all_identifier";
  const ParticipantAll({required super.permissions, super.email = addAllIdentifier, super.name = addAllIdentifier });

  @override
  ParticipantAll copyWith({ParticipantPermissions? permissions}) {
    return ParticipantAll(
         permissions: permissions ?? this.permissions);
  }
}

enum ParticipantPermissions { read, readWrite }

extension ParticipantPermissionsMapper on ParticipantPermissions {
  static ParticipantPermissions fromCode(int code) {
    switch (code) {
      case 1:
        return ParticipantPermissions.readWrite;
      case 2:
        return ParticipantPermissions.read;
      default:
        throw Exception('Unknown code: $code');
    }
  }

  int get code {
    switch (this) {
      case ParticipantPermissions.read:
        return 2;
      case ParticipantPermissions.readWrite:
       return 1;
    }
  }
}
