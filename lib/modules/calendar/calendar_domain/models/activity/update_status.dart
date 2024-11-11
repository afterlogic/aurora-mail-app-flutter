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
