import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/reminders_option.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/section_with_icon.dart';
import 'package:flutter/material.dart';

class RemindersSection extends StatelessWidget {
  const RemindersSection({super.key, required this.reminders});

  final Set<RemindersOption>? reminders;

  @override
  Widget build(BuildContext context) {
    return SectionWithIcon(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: reminders != null && reminders!.length > 1 ? 0.0 : 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (reminders?.isEmpty ?? true)
                    Text(
                      'Reminders',
                    ),
                  ...?reminders
                      ?.map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text('${e.buildString} before'),
                          ))
                      .toList()
                ],
              ),
            ),
          ],
        ),
      ],
      icon: Padding(
        padding: EdgeInsets.only(
            top: reminders != null && reminders!.length > 1 ? 0.0 : 6.0),
        child: Icon(
          Icons.notifications_none,
          size: 15,
        ),
      ),
    );
  }
}
