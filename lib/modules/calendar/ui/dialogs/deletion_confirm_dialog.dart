import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:flutter/material.dart';

class CalendarConfirmDialog extends StatelessWidget {
  final String title;
  final String confirmMessage;
  const CalendarConfirmDialog({required this.title, required this.confirmMessage});

  static Future<bool?> show(BuildContext context,
      {required String title, String confirmMessage = "Confirm action"}) {
    return showDialog<bool?>(
        context: context,
        builder: (_) => CalendarConfirmDialog(
          confirmMessage: confirmMessage,
          title: title,
        )).then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
    return BaseCalendarDialog(
      title: title,
      actions: [
        TextButton(
          child: Text(S.of(context).btn_cancel),
          onPressed: () => Navigator.pop(context, false),
        ),
        TextButton(
          child: Text(S.of(context).btn_delete),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(confirmMessage)
        ],
      ),
    );
  }
}

