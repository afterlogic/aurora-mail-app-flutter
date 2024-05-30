import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:flutter/material.dart';

class RemindersDialog extends StatefulWidget {
  final RemindersOption initialValue;
  const RemindersDialog({required this.initialValue});

  static Future<RemindersOption?> show(BuildContext context,
      {required RemindersOption initialValue}) {
    return showDialog<RemindersOption?>(
        context: context,
        builder: (_) => RemindersDialog(
              initialValue: initialValue,
            )).then((value) => value);
  }

  @override
  State<RemindersDialog> createState() => _RemindersOptionState();
}

class _RemindersOptionState extends State<RemindersDialog> {
  RemindersOption? _selectedOption;

  @override
  void initState() {
    _selectedOption = widget.initialValue;
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
          ...RemindersOption.values.map((option) {
            return RadioListTile<RemindersOption>(
              dense: true,
              title: Text(
                option.buildString,
                style: TextStyle(fontSize: 14),
              ),
              value: option,
              groupValue: _selectedOption,
              onChanged: (RemindersOption? value) {
                setState(() {
                  _selectedOption = value;
                });
                Navigator.pop(context, _selectedOption);
              },
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

enum RemindersOption {
  min5,
  min10,
  min15,
  min30,
  hours1,
  hours2,
  hours3,
}

extension RemindersOptionString on RemindersOption {
  String get buildString {
    switch (this) {
      case RemindersOption.min5:
        return '5 minutes';
      case RemindersOption.min10:
        return '10 minutes';
      case RemindersOption.min15:
        return '15 minutes';
      case RemindersOption.min30:
        return '30 minutes';
      case RemindersOption.hours1:
        return '1 hours';
      case RemindersOption.hours2:
        return '2 hours';
      case RemindersOption.hours3:
        return '3 hours';
    }
  }
}
