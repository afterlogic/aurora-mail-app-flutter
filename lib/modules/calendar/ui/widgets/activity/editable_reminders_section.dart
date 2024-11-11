import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/reminders_option.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/reminders_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/add_icon.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/section_with_icon.dart';
import 'package:flutter/material.dart';

class EditableRemindersSection extends StatelessWidget {
  final Set<RemindersOption> selectedReminders;
  final void Function(RemindersOption option) onDeleteCallback;
  final void Function(RemindersOption option) onAddCallback;
  const EditableRemindersSection(
      {super.key,
      required this.selectedReminders,
      required this.onAddCallback,
      required this.onDeleteCallback});

  @override
  Widget build(BuildContext context) {
    return SectionWithIcon(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: selectedReminders.length > 1 ? 0.0 : 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedReminders.isEmpty)
                    Text(
                      'Reminders',
                    ),
                  ...selectedReminders
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('${e.buildString} before'),
                                GestureDetector(
                                  onTap: () => onDeleteCallback(e),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Icon(
                                      Icons.close,
                                      size: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ))
                      .toList()
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  RemindersDialog.show(context,
                          selectedOptions: selectedReminders)
                      .then((value) {
                    if (value == null) return;
                    onAddCallback(value);
                  });
                },
                child: const AddIcon()),
          ],
        ),
      ],
      icon: Padding(
        padding: EdgeInsets.only(top: selectedReminders.length > 1 ? 0.0 : 6.0),
        child: Icon(
          Icons.notifications_none,
          size: 15,
        ),
      ),
    );
  }
}
