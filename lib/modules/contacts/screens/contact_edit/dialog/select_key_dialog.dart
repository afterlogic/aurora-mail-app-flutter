import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/components/key_item.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/material.dart';

class SelectKeyDialog extends StatelessWidget {
  final List<PgpKey> keys;

  const SelectKeyDialog(this.keys);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).label_contact_select_key),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: keys.map((key) {
          return InkWell(
            onTap: () => Navigator.pop(context, key),
            child: KeyItem(pgpKey: key),
          );
        }).toList(),
      ),
    );
  }
}
