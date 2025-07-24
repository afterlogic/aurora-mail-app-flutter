import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/attendee.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/attendee_card.dart';
import 'package:flutter/material.dart';

class AttendeesSection extends StatelessWidget {
  final Set<Attendee> attendees;

  const AttendeesSection({super.key, required this.attendees});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.group,
              size: 15,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              S.current.calendar_add_attendee_title,
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(runSpacing: 4, spacing: 4, children: [
          ...attendees.map(
            (e) => LayoutBuilder(builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: (constraints.maxWidth / 2) - 4,
                ),
                child: AttendeeCard(
                  attendee: e,
                  onDelete: null,
                ),
              );
            }),
          ),
        ]),
      ],
    );
  }
}
