import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/InviteStatus.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/attendee.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:flutter/material.dart';

class AttendeeCard extends StatelessWidget {
  const AttendeeCard(
      {super.key, required this.attendee, required this.onDelete});

  final Attendee attendee;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color:  Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.blue[50],
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        horizontalTitleGap: 0,
        dense: true,
        leading: Icon(Icons.circle, color: attendee.status.color),
        title: Text(
          attendee.email,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: onDelete == null ? null : IconButton(
          icon: Icon(Icons.close),
          onPressed: onDelete,
        ),
      ),
    );
  }
}

extension InviteStatusColor on InviteStatus {
  Color get color {
    switch (this) {
      case InviteStatus.accepted:
        return Colors.green;
      case InviteStatus.denied:
        return Colors.red;
      case InviteStatus.pending:
        return Color(0xFFEF954F);
      case InviteStatus.unknown:
        return Colors.grey;
    }
  }
}
