import 'package:aurora_mail/modules/settings/screens/pgp_settings/components/key_item.dart';
import 'package:aurora_mail/shared_ui/sized_dialog_content.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/material.dart';

class SelectKeyDialog extends StatelessWidget {
  final List<PgpKey> keys;

  const SelectKeyDialog(this.keys);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(i18n(context, "select_key")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
          children: keys.map((key) {
            return InkWell(
              onTap: () => Navigator.pop(context, key),
              child: KeyItem(key, null, null),
            );
          }).toList(),
      ),
    );
  }
}