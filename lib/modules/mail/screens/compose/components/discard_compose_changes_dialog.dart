import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';

enum DiscardComposeChangesOption { discard, save }

class DiscardComposeChangesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return AlertDialog(
      title: Text(i18n(context, "compose_discard_save_dialog_title")),
      content: Text(i18n(context, "compose_discard_save_dialog_description")),
      actions: <Widget>[
        FlatButton(
          textColor:
              theme.brightness == Brightness.light ? theme.accentColor : null,
          child: Text(i18n(context, "btn_cancel")),
          onPressed: () {
            Navigator.pop(context);
            return DiscardComposeChangesOption.save;
          },
        ),
        FlatButton(
          textColor:
              theme.brightness == Brightness.light ? theme.accentColor : null,
          child: Text(i18n(context, "btn_discard")),
          onPressed: () {
            Navigator.pop(context);
            return DiscardComposeChangesOption.discard;
          },
        ),
        FlatButton(
          textColor:
              theme.brightness == Brightness.light ? theme.accentColor : null,
          child: Text(i18n(context, "btn_save")),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
