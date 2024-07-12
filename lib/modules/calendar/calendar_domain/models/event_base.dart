import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/update_status.dart';
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

  ActivityDb toDb() {
    return ActivityDb(
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
    return
        ' uid: $uid,' +
        ' updateStatus: ${updateStatus.name},' ;
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
