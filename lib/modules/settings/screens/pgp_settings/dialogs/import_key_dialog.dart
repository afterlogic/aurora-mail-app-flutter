import 'package:aurora_mail/modules/settings/screens/pgp_settings/components/key_item.dart';
import 'package:aurora_mail/shared_ui/sized_dialog_content.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';

class ImportKeyDialog extends StatefulWidget {
  final Map<PgpKey, bool> pgpKeys;

  const ImportKeyDialog(this.pgpKeys);

  @override
  _ImportKeyDialogState createState() => _ImportKeyDialogState();
}

class _ImportKeyDialogState extends BState<ImportKeyDialog> {
  final List<PgpKey> keys = [];
  bool keyAlreadyExist = false;

  @override
  void initState() {
    super.initState();
    widget.pgpKeys.forEach((key, value) {
      keys.add(key);
      if (value == null) {
        keyAlreadyExist = true;
      }
    });
    if (keyAlreadyExist) {
      keys.insert(0, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(i18n(context, "import_key")),
      content: SizedDialogContent(
        child: ListView.builder(
          itemCount: keys.length,
          itemBuilder: (_, i) {
            if (keyAlreadyExist && i == 0) {
              return Text(i18n(context, "already_have_keys"));
            }
            final key = keys[i];
            return KeyItem(
              key,
              widget.pgpKeys[key],
              (select) {
                widget.pgpKeys[key] = select;
                setState(() {});
              },
            );
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, "btn_cancel")),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text(i18n(context, "import_selected_key")),
          onPressed: () => Navigator.pop(context, widget.pgpKeys),
        ),
      ],
    );
  }
}
