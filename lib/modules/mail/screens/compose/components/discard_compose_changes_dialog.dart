import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/material.dart';

enum DiscardComposeChangesOption { discard, save }

class DiscardComposeChangesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      // title: Text(i18n(context, S.compose_discard_save_dialog_title)),
      content: Text(i18n(context, S.compose_discard_save_dialog_description)),
      actions: <Widget>[
        // FlatButton(
        //   textColor:
        //       theme.brightness == Brightness.light ? theme.accentColor : null,
        //   child: Text(i18n(context, S.btn_cancel)),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        FlatButton(
          textColor:
              theme.brightness == Brightness.light ? theme.accentColor : null,
          child: Text(i18n(context, S.btn_discard)),
          onPressed: () {
            Navigator.pop(context, DiscardComposeChangesOption.discard);
          },
        ),
        FlatButton(
          textColor:
              theme.brightness == Brightness.light ? theme.accentColor : null,
          child: Text(i18n(context, S.btn_save)),
          onPressed: () {
            Navigator.pop(context, DiscardComposeChangesOption.save);
          },
        ),
      ],
    );
  }
}
