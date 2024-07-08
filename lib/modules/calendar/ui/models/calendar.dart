import 'dart:ui';

import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:equatable/equatable.dart';

class ViewCalendar extends Calendar implements Equatable {
  final bool selected;

  ViewCalendar(
      {this.selected = true,
      required super.id,
      required super.userLocalId,
      required super.color,
      required super.name,
      required super.owner,
      required super.isDefault,
      required super.shared,
      required super.sharedToAll,
      super.description,
      required super.sharedToAllAccess,
      required super.access,
      required super.isPublic,
      required super.syncToken,
      required super.isSubscribed,
      required super.source,
      required super.serverUrl,
      required super.url,
      required super.exportHash,
      required super.pubHash,
      required super.shares});

  ViewCalendar updateSelect(bool selected) => copyWith(
      selected: selected,
     );

  @override
  List<Object?> get props => [
        selected,
        id,
        userLocalId,
        color,
        name,
        owner,
        isDefault,
        shared,
        sharedToAll,
        description,
        sharedToAllAccess,
        access,
        isPublic,
        source,
        isSubscribed,
        syncToken,
        serverUrl,
        url,
        exportHash,
        pubHash,
        shares
      ];

  @override
  bool? get stringify => null;

  @override
  ViewCalendar copyWith({
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
    bool? selected,
    String? syncToken,
    String? serverUrl,
    String? url,
    String? exportHash,
    String? pubHash,
    Set<Participant>? shares,
  }) {
    return ViewCalendar(
      selected: selected ?? this.selected,
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
      source: source ?? this.source,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      serverUrl: serverUrl ?? this.serverUrl,
      url: url ?? this.url,
      exportHash: exportHash ?? this.exportHash,
      pubHash: pubHash ?? this.pubHash,
      shares: shares ?? this.shares,
      syncToken: syncToken ?? this.syncToken,
    );
  }

  bool updated(ViewCalendar comparable) {
    return name != comparable.name ||
        description != comparable.description ||
        isSubscribed != comparable.isSubscribed ||
        isPublic != comparable.isPublic ||
        source != comparable.source ||
        color != comparable.color;
  }
}
