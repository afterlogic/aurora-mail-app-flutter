import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/days_of_week.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/every_week_frequency.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/daily_recurrence_select_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/recurrence_mode_select_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/weekly_recurrence_select_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/section_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditableRecurrenceSection extends StatelessWidget {
  final RecurrenceMode selectedRecurrenceMode;
  final EveryWeekFrequency? selectedWeeklyFrequency;
  final Set<DaysOfWeek>? selectedWeekDaysRepeat;
  final DateTime? selectedUntilDate;
  final void Function(DateTime? untilDate, EveryWeekFrequency? frequency,
      Set<DaysOfWeek>? selectedDays) recurrencySaveCallback;
  final void Function(DateTime? untilDate) selectedDateSaveCallback;
  final void Function(RecurrenceMode mode) selectedRecurrenceModeCallback;
  const EditableRecurrenceSection(
      {super.key,
      required this.selectedRecurrenceMode,
      this.selectedWeeklyFrequency,
      this.selectedWeekDaysRepeat,
      this.selectedUntilDate,
      required this.recurrencySaveCallback,
      required this.selectedDateSaveCallback,
      required this.selectedRecurrenceModeCallback});

  @override
  Widget build(BuildContext context) {
    return SectionWithIcon(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                RecurrenceModeSelectDialog.show(context,
                        selectedOption: selectedRecurrenceMode)
                    .then((value) {
                  if (value == null) return;
                  selectedRecurrenceModeCallback(value);
                });
              },
              child: Text(
                selectedRecurrenceMode.buildString(context),
                style: TextStyle(),
              ),
            ),
            Spacer(),
            if (selectedRecurrenceMode.isUntilOptionAvailable)
              GestureDetector(
                onTap: () {
                  if (selectedRecurrenceMode == RecurrenceMode.daily) {
                    DailyRecurrenceSelectDialog.show(context,
                        untilDate: selectedUntilDate,
                        onSaveCallback: selectedDateSaveCallback);
                  }
                  if (selectedRecurrenceMode == RecurrenceMode.weekly) {
                    WeeklyRecurrenceSelectDialog.show(context,
                        frequency: selectedWeeklyFrequency,
                        selectedDays: selectedWeekDaysRepeat,
                        untilDate: selectedUntilDate,
                        onSaveCallback: recurrencySaveCallback);
                  }
                },
                child: selectedUntilDate == null
                    ? Text(
                        'Always',
                      )
                    : Text(
                        'until ${DateFormat('yyyy/MM/dd').format(selectedUntilDate!)}'),
              ),
          ],
        ),
      ],
      icon: Icon(
        Icons.sync,
        size: 15,
      ),
    );
  }
}
