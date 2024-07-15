import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/date_time_tile.dart';
import 'package:flutter/material.dart';

class DateInfo extends StatelessWidget {
  final Activity activity;

  const DateInfo({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (activity.startTS != null)
          DateTimeTile(
            dateTime: activity.startTS!,
            isAllDay: activity.allDay ?? true,
          ),
        const SizedBox(
          height: 16,
        ),
        if (activity.endTS != null)
          DateTimeTile(
            dateTime: activity.endTS!,
            isAllDay: activity.allDay ?? true,
          ),
      ],
    );
  }
}
