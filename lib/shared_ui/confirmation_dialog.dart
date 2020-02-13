import 'dart:io';

import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  final String actionText;
  final bool destructibleAction;

  const ConfirmationDialog({
    Key key,
    @required this.title,
    @required this.description,
    @required this.actionText,
    this.destructibleAction = false,
  }) : super(key: key);

  static Future<bool> show(
    BuildContext context,
    String title,
    String description,
    String actionText,
    {bool destructibleAction}
  ) {
    return dialog(
        context: context,
        builder: (_) => ConfirmationDialog(
              title: title,
              description: description,
              actionText: actionText,
              destructibleAction: destructibleAction,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, "btn_cancel")),
          onPressed: () => Navigator.pop(context, false),
        ),
        FlatButton(
          child: Text(actionText),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }
}
