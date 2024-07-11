import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/update_status.dart';

class ActivityBase {
  final String uid;
  final UpdateStatus updateStatus;
  final int userLocalId;
  final String calendarId;
  final bool synced;

  const ActivityBase({
    required this.uid,
    required this.updateStatus,
    required this.userLocalId,
    required this.calendarId,
    required this.synced
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
}
