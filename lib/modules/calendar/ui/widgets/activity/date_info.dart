import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/ui/models/displayable.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/date_time_tile.dart';
import 'package:flutter/material.dart';

class DateInfo extends StatelessWidget {
  final Displayable displayable;

  const DateInfo({super.key, required this.displayable});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (displayable.startDate != null)
          DateTimeTile(
            dateTime: displayable.startDate!,
            isAllDay: displayable.allDay ?? true,
          )else
            Text('No start date selected'),
        const SizedBox(
          height: 16,
        ),
        if (displayable.endDate != null)
          DateTimeTile(
            dateTime: displayable.endDate!,
            isAllDay: displayable.allDay ?? true,
          )else
          Text('No end date selected'),
      ],
    );
  }
}
