enum InviteStatus { accepted, denied, pending, unknown }

extension InviteStatusMapper on InviteStatus {
  static InviteStatus fromCode(int code) {
    switch (code) {
      case 1:
        return InviteStatus.accepted;
      case 0:
        return InviteStatus.pending;
      case 2:
        return InviteStatus.denied;
      default:
        return InviteStatus.unknown;
    }
  }

  int get statusCode {
    switch (this) {
      case InviteStatus.unknown:
        return -1;
      case InviteStatus.accepted:
        return 1;
      case InviteStatus.pending:
        return 0;
      case InviteStatus.denied:
        return 2;
    }
  }
}