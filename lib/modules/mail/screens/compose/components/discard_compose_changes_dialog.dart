import 'package:aurora_mail/generated/l10n.dart';
import 'package:flutter/material.dart';

enum DiscardComposeChangesOption { discard, save }

class DiscardComposeChangesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      content: Text(S.of(context).compose_discard_save_dialog_description),
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
            Navigator.pop(context, DiscardComposeChangesOption.discard);
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
            Navigator.pop(context, DiscardComposeChangesOption.save);
          },
        ),
      ],
    );
  }
}
