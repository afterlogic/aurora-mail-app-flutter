import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/material.dart';

enum DiscardComposeChangesOption { discard, save }

class DiscardComposeChangesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      content: Text(i18n(context, S.compose_discard_save_dialog_description)),
      actions: <Widget>[
        TextButton(
          child: Text(
            i18n(context, S.btn_discard),
            style: TextStyle(
                color: theme.brightness == Brightness.light
                    ? theme.accentColor
                    : null),
          ),
          onPressed: () {
            Navigator.pop(context, DiscardComposeChangesOption.discard);
          },
        ),
        TextButton(
          child: Text(
            i18n(context, S.btn_save),
            style: TextStyle(
                color: theme.brightness == Brightness.light
                    ? theme.accentColor
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
