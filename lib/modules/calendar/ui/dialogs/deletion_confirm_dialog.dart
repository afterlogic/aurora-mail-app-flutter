import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:flutter/material.dart';

class CalendarConfirmDialog extends StatelessWidget {
  final String title;
  final String confirmMessage;
  final List<Widget>? actions;
  const CalendarConfirmDialog({required this.title, this.actions, required this.confirmMessage});

  static Future<bool?> show(BuildContext context,
      {required String title, List<Widget>? actions, String confirmMessage = "Confirm action"}) {
    return showDialog<bool?>(
        context: context,
        builder: (_) => CalendarConfirmDialog(
          actions: actions,
          confirmMessage: confirmMessage,
          title: title,
        )).then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
    return BaseCalendarDialog(
      title: title,
      actions: actions == null ? [
        TextButton(
          child: Text(S.of(context).btn_cancel),
          onPressed: () => Navigator.pop(context, false),
        ),
        TextButton(
          child: Text(S.of(context).btn_delete),
          onPressed: () => Navigator.pop(context, true),
        ),
      ] : actions,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(confirmMessage)
        ],
      ),
    );
  }
}

