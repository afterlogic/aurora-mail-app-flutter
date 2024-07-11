import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:aurora_mail/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class RecurrenceModeSelectDialog extends StatefulWidget {
  final RecurrenceMode selectedOption;
  const RecurrenceModeSelectDialog({required this.selectedOption});

  static Future<RecurrenceMode?> show(BuildContext context,
      {required RecurrenceMode selectedOption}) {
    return showDialog<RecurrenceMode?>(
        context: context,
        builder: (_) => RecurrenceModeSelectDialog(
              selectedOption: selectedOption,
            )).then((value) => value);
  }

  @override
  State<RecurrenceModeSelectDialog> createState() =>
      _RecurrenceModeSelectDialogState();
}

class _RecurrenceModeSelectDialogState
    extends State<RecurrenceModeSelectDialog> {
  late RecurrenceMode? _selectedOption;

  @override
  void initState() {
    _selectedOption = widget.selectedOption;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseCalendarDialog(
      removeContentPadding: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Spacer(),
              CloseButton(
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
          ...RecurrenceMode.values.map((option) {
            return RadioListTile<RecurrenceMode>(
              dense: true,
              title: Text(
                option.buildString(context),
                style: TextStyle(fontSize: 14),
              ),
              value: option,
              onChanged: (value) {
                _selectedOption = value;
                setState(() {});
                Navigator.pop(context, option);
              },
              groupValue: _selectedOption,
            );
          }).toList(),
          const SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }
}
