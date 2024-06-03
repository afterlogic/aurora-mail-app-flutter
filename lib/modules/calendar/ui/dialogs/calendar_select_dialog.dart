import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/calendar_tile.dart';
import 'package:flutter/material.dart';

class CalendarSelectDialog extends StatefulWidget {
  final ViewCalendar? initialValue;
  final List<ViewCalendar> options;
  const CalendarSelectDialog({required this.initialValue, required this.options});

  static Future<ViewCalendar?> show(BuildContext context,
      {ViewCalendar? initialValue, required List<ViewCalendar> options}) {
    return showDialog<ViewCalendar?>(
        context: context,
        builder: (_) => CalendarSelectDialog(
          initialValue: initialValue,
          options: options,
        )).then((value) => value);
  }

  @override
  State<CalendarSelectDialog> createState() => _CalendarSelectDialogState();
}

class _CalendarSelectDialogState extends State<CalendarSelectDialog> {
  ViewCalendar? _selectedOption;

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
          ...widget.options.map((option) {
            return Theme(
              data: Theme.of(context).copyWith(
                listTileTheme: ListTileThemeData(
                  horizontalTitleGap: 0,
                ),
              ),
              child: RadioListTile<ViewCalendar>(
                dense: true,
                title: CalendarTile(circleColor: option.color, text: option.name, backgroundColor: null,),
                value: option,
                groupValue: _selectedOption,
                onChanged: (ViewCalendar? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                  Navigator.pop(context, _selectedOption);
                },
              ),
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

