//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/dialog/select_key_dialog.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/import_from_text_dialog.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/screens/pgp_key_route.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/material.dart';

class KeyInput extends StatefulWidget {
  final PgpSettingsBloc pgpSettingsBloc;
  final PgpKey pgpKey;
  final Function(PgpKey) onEdit;
  final Function(String) onError;

  const KeyInput(
    this.pgpSettingsBloc,
    this.pgpKey,
    this.onEdit,
    this.onError,
  );

  @override
  State<StatefulWidget> createState() => KeyInputState();
}

class KeyInputState extends State<KeyInput> {
  PgpKey pgpKey;

  @override
  void initState() {
    super.initState();
    pgpKey = widget.pgpKey;
  }

  @override
  Widget build(BuildContext context) {
    if (pgpKey != null)
      return ListTile(
        leading: Icon(Icons.vpn_key),
        title: Text(pgpKey.formatName() +
            "\n${pgpKey.key?.length != null ? "(${pgpKey.length}-bit," : "("} ${pgpKey.isPrivate ? "private" : "public"})"),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 20,
        ),
        onTap: () => _openKey(),
      );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextButton(
          child: Text(S.of(context).btn_pgp_import_from_text),
          onPressed: () async {
            final result = await dialog(
              context: context,
              builder: (_) => ImportFromTextDialog(),
            );
            if (result is String) {
              _onKey(result);
            }
          },
        ),
        TextButton(
          child: Text(S.of(context).btn_pgp_import_from_file),
          onPressed: () async {
            final result = await widget.pgpSettingsBloc.getKeyFromFile();
            if (result is String) {
              _onKey(result);
            }
          },
        ),
      ],
    );
  }

  _openKey() {
    Navigator.pushNamed(
      context,
      PgpKeyRoute.name,
      arguments: PgpKeyRouteArg(
        widget.pgpKey,
        () {
          _setKey(null);
        },
        true,
        widget.pgpSettingsBloc,
      ),
    );
  }

  _onKey(String key) async {
    final keys = (await widget.pgpSettingsBloc.parseKey(key))
        .where((item) => !item.isPrivate)
        .toList();
    if (keys.isEmpty) {
      showSnack(
          context: context,
          scaffoldState: Scaffold.of(context),
          message: S.of(context).error_no_pgp_key);
      return;
    }
    if (keys.length == 1) {
      _setKey(keys.first);
    } else {
      final result =
          await dialog(context: context, builder: (_) => SelectKeyDialog(keys));
      if (result is PgpKey) {
        _setKey(result);
      }
    }
  }

  _setKey(PgpKey key) {
    widget.onEdit(key);
    pgpKey = key;
    setState(() {});
  }
}
