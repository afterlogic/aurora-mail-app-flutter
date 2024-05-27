import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:equatable/equatable.dart';

class ViewCalendar extends Calendar implements Equatable {
  final bool selected;

  ViewCalendar(
      {this.selected = false,
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
}
