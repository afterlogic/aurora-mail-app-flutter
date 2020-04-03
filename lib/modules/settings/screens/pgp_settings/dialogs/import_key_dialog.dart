import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/components/key_item.dart';
import 'package:aurora_mail/shared_ui/sized_dialog_content.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/material.dart';

class ImportKeyDialog extends StatefulWidget {
  final Map<PgpKey, bool> userKeys;
  final Map<PgpKeyWithContact, bool> contactKeys;

  const ImportKeyDialog(
    this.userKeys,
    this.contactKeys,
  );

  @override
  _ImportKeyDialogState createState() => _ImportKeyDialogState();
}

class _ImportKeyDialogState extends BState<ImportKeyDialog> {
  final List<PgpKey> userKeys = [];
  final List<PgpKeyWithContact> contactKeys = [];
  bool keyAlreadyExist = false;

  @override
  void initState() {
    super.initState();
    widget.userKeys.forEach((key, value) {
      userKeys.add(key);
      if (value == null) {
        keyAlreadyExist = true;
      }
    });
    widget.contactKeys.forEach((key, value) {
      contactKeys.add(key);
      if (value == null) {
        keyAlreadyExist = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(i18n(context, "import_key")),
      content: SizedDialogContent(
        child: ListView(
          children: <Widget>[
            if (keyAlreadyExist)
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(i18n(context, "already_have_keys"))),
            if (userKeys.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(i18n(context, "user_key")),
              ),
            Column(
              children: userKeys.map((key) {
                return KeyItem(key, widget.userKeys[key], (select) {
                  widget.userKeys[key] = select;
                  setState(() {});
                });
              }).toList(),
            ),
            if (contactKeys.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(i18n(context, "contact_keys")),
              ),
            Column(
              children: contactKeys.map((key) {
                return KeyItem(key, widget.contactKeys[key], (select) {
                  widget.contactKeys[key] = select;
                  setState(() {});
                });
              }).toList(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, "btn_cancel")),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text(i18n(context, "import_selected_key")),
          onPressed: () => Navigator.pop(
              context,
              PgpKeyMap(
                widget.userKeys,
                widget.contactKeys,
              )),
        ),
      ],
    );
  }
}
