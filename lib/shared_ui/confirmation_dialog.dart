//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  final String actionText;
  final List<Widget> actions;
  final bool destructibleAction;

  const ConfirmationDialog({
    Key key,
    @required this.title,
    @required this.description,
    @required this.actionText,
    this.actions,
    this.destructibleAction = false,
  }) : super(key: key);

  static Future<bool> show(
    BuildContext context,
    String title,
    String description,
    String actionText, {
    List<Widget> actions,
    bool destructibleAction,
  }) {
    return dialog(
        context: context,
        builder: (_) => ConfirmationDialog(
              title: title,
              description: description,
              actionText: actionText,
              actions: actions,
              destructibleAction: destructibleAction,
            )).then((value) => (value as bool) ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title == null ? null : Text(title),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).btn_cancel),
          onPressed: () => Navigator.pop(context, false),
        ),
        if (actions != null) ...actions,
        TextButton(
          child: Text(actionText),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }
}
