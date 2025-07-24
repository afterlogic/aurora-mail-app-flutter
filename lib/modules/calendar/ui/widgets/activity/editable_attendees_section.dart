import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/attendee.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/add_icon.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/attendee_card.dart';
import 'package:flutter/material.dart';

class EditableAttendeesSection extends StatelessWidget {
  final Set<Attendee> attendees;
  final VoidCallback onAddPressed;
  final void Function(Attendee attendee) onDeletedCallback;

  const EditableAttendeesSection(
      {super.key,
      required this.attendees,
      required this.onAddPressed,
      required this.onDeletedCallback});

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
            GestureDetector(onTap: onAddPressed, child: const AddIcon()),
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
                  onDelete: () => onDeletedCallback(e),
                ),
              );
            }),
          ),
        ]),
      ],
    );
  }
}
