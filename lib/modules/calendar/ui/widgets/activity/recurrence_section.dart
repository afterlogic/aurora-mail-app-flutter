import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/section_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecurrenceSection extends StatelessWidget {
  final Activity activity;

  const RecurrenceSection({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return SectionWithIcon(
      children: [
        Row(
          children: [
            Text(
              activity.recurrenceMode?.buildString(context) ?? '',
            ),
            Spacer(),
            if (activity.recurrenceMode != RecurrenceMode.never)
              Text(
                activity.recurrenceUntilDate == null
                    ? 'Always'
                    : 'until ${DateFormat('yyyy/MM/dd').format(activity.recurrenceUntilDate!)}',
              ),
          ],
        ),
      ],
      icon: const Icon(
        Icons.sync,
        size: 15,
      ),
    );
  }
}
