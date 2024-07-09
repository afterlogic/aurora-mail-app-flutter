import 'package:aurora_mail/generated/l10n.dart';
import 'package:flutter/material.dart';

enum DiscardChangesOption { discard, save }

class DiscardChangesDialog extends StatelessWidget {
  final Widget content;

  const DiscardChangesDialog({required this.content});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      content: content,
      actions: <Widget>[
        TextButton(
          child: Text(
            S.of(context).btn_discard,
            style: TextStyle(
                color: theme.brightness == Brightness.light
                    ? theme.primaryColor
                    : null),
          ),
          onPressed: () {
            Navigator.pop(context, DiscardChangesOption.discard);
          },
        ),
        TextButton(
          child: Text(
            S.of(context).btn_save,
            style: TextStyle(
                color: theme.brightness == Brightness.light
                    ? theme.primaryColor
                    : null),
          ),
          onPressed: () {
            Navigator.pop(context, DiscardChangesOption.save);
          },
        ),
      ],
    );
  }
}
