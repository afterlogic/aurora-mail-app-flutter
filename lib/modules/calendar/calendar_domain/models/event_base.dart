import 'package:aurora_mail/database/app_database.dart';
import 'package:drift/drift.dart';

class EventBase {
  final String uid;
  final UpdateStatus updateStatus;
  final int userLocalId;
  final String calendarId;

  const EventBase({
    required this.uid,
    required this.updateStatus,
    required this.userLocalId,
    required this.calendarId,
  });

  EventDb toDb() {
    return EventDb(
        calendarId: calendarId,
        userLocalId: userLocalId,
        uid: uid,
        updateStatus: updateStatus,
        synced: false,
        onceLoaded: false);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventBase &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          userLocalId == other.userLocalId &&
          calendarId == other.calendarId &&
          updateStatus == other.updateStatus);

  @override
  int get hashCode =>
      uid.hashCode ^
      userLocalId.hashCode ^
      calendarId.hashCode ^
      updateStatus.hashCode;

  @override
  String toString() {
    return 'EventUpdateInfo{' +
        ' uid: $uid,' +
        ' calendarId: $calendarId,' +
        ' userLocalId: $userLocalId,' +
        ' updateStatus: ${updateStatus.name},' +
        '}';
  }

  EventBase copyWith({
    String? uid,
    String? calendarId,
    int? userLocalId,
    UpdateStatus? updateStatus,
  }) {
    return EventBase(
      uid: uid ?? this.uid,
      calendarId: calendarId ?? this.calendarId,
      userLocalId: userLocalId ?? this.userLocalId,
      updateStatus: updateStatus ?? this.updateStatus,
    );
  }
}

enum UpdateStatus { added, modified, deleted }

extension UpdateStatusX on UpdateStatus {
  String toApiString() {
    switch (this) {
      case UpdateStatus.added:
        return "added";
      case UpdateStatus.modified:
        return "modified";
      case UpdateStatus.deleted:
        return "deleted";
    }
  }

  bool get isDeleted => this == UpdateStatus.deleted;

  static UpdateStatus? fromApiString(String status) {
    switch (status) {
      case "Added":
        return UpdateStatus.added;
      case "Modified":
        return UpdateStatus.modified;
      case "Deleted":
        return UpdateStatus.deleted;
      default:
        return null;
    }
  }
}
