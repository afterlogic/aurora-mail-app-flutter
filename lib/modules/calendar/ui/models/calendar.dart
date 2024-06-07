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
      required super.syncToken});

  ViewCalendar updateSelect(bool selected) => ViewCalendar(
      selected: selected,
      id: id,
      userLocalId: userLocalId,
      color: color,
      name: name,
      owner: owner,
      isDefault: isDefault,
      shared: shared,
      sharedToAll: sharedToAll,
      description: description,
      sharedToAllAccess: sharedToAllAccess,
      access: access,
      isPublic: isPublic,
      syncToken: syncToken);

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
        syncToken
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
    List? shares,
    String? syncToken,
  }) {
    return ViewCalendar(
      selected: this.selected,
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
      // shares: shares ?? this.shares,
      syncToken: syncToken ?? this.syncToken,
    );
  }

  bool updated(ViewCalendar comparable) {
    return name != comparable.name ||
        description != comparable.description ||
        color != comparable.color;
  }
}
