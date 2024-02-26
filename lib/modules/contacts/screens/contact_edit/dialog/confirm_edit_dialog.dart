import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class ConfirmationEditDialog extends StatelessWidget {
  const ConfirmationEditDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(i18n(context, S.error_contact_pgp_key_will_not_be_valid)),
      actions: <Widget>[
        TextButton(
          child: Text(i18n(context, S.btn_cancel)),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(i18n(context, S.btn_contact_key_re_import)),
          onPressed: () => Navigator.pop(context, FreeKeyAction.Import),
        ),
        TextButton(
          child: Text(i18n(context, S.btn_contact_delete_key)),
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
