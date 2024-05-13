import 'package:drift/drift.dart';

@DataClassName("EventUpdateInfoDb")
class EventUpdateInfoTable extends Table {
  TextColumn get uid => text()();
  IntColumn get updateStatus => intEnum<UpdateStatus>()();
}

class EventUpdateInfo {
  final String uid;
  final UpdateStatus updateStatus;

  const EventUpdateInfo({
    required this.uid,
    required this.updateStatus,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventUpdateInfo &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          updateStatus == other.updateStatus);

  @override
  int get hashCode => uid.hashCode ^ updateStatus.hashCode;

  @override
  String toString() {
    return 'EventUpdateInfo{' +
        ' uid: $uid,' +
        ' updateStatus: ${updateStatus.name},' +
        '}';
  }

  EventUpdateInfo copyWith({
    String? uid,
    UpdateStatus? updateStatus,
  }) {
    return EventUpdateInfo(
      uid: uid ?? this.uid,
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

  static UpdateStatus? fromApiString(String status) {
    switch (status) {
      case "added":
        return UpdateStatus.added;
      case "modified":
        return UpdateStatus.modified;
      case "deleted":
        return UpdateStatus.deleted;
      default:
        return null;
    }
  }
}
