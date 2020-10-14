import 'package:aurora_mail/utils/internationalization.dart'; import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
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
        FlatButton(
          child: Text(i18n(context, S.btn_cancel)),
          onPressed: () => Navigator.pop(context, false),
        ),
        if (actions != null) ...actions,
        FlatButton(
          child: Text(actionText),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }
}
