import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  final String actionText;

  const ConfirmationDialog({
    Key key,
    @required this.title,
    @required this.description,
    @required this.actionText,
  }) : super(key: key);

  static Future<bool> show(
    BuildContext context,
    String title,
    String description,
    String actionText,
  ) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
          context: context,
          builder: (_) =>
              ConfirmationDialog(
                title: title,
                description: description,
                actionText: actionText,
              ));
    } else {
      return showDialog(
          context: context,
          builder: (_) =>
              ConfirmationDialog(
                title: title,
                description: description,
                actionText: actionText,
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          CupertinoButton(
            child: Text(actionText),
            onPressed: () => Navigator.pop(context, true),
          ),
          CupertinoButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          FlatButton(
            child: Text("Cancel".toUpperCase()),
            onPressed: () => Navigator.pop(context, false),
          ),
          FlatButton(
            child: Text(actionText.toUpperCase()),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      );
    }
  }
}
