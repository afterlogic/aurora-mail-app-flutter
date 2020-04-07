import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class ConfirmationEditDialog extends StatelessWidget {
  const ConfirmationEditDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(i18n(context, "key_will_not_be_valid")),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, "btn_cancel")),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text(i18n(context, "re_import")),
          onPressed: () => Navigator.pop(context, FreeKeyAction.Import),
        ),
        FlatButton(
          child: Text(i18n(context, "delete_key")),
          onPressed: () => Navigator.pop(context, FreeKeyAction.Delete),
        ),
      ],
    );
  }
}

enum FreeKeyAction {
  Delete,
  Import,
}
