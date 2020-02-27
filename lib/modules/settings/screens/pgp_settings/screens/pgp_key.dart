import 'dart:io';

import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PgpKeyScreen extends StatelessWidget {
  final PgpKey pgpKey;
  final PgpSettingsBloc bloc;

  const PgpKeyScreen(this.pgpKey, this.bloc);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AMAppBar(
        title: Text(i18n(
          context,
          pgpKey.isPrivate ? "public_key" : "private_key",
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Text(
                    pgpKey.mail,
                    style: theme.textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SelectableText(pgpKey.key),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                _space(),
                SizedBox(
                  width: double.infinity,
                  child: AMButton(
                    child: Text(i18n(context, "share")),
                    onPressed: () {
                      bloc.add(ShareKeys([pgpKey]));
                      Navigator.pop(context);
                    },
                  ),
                ),
                if (!Platform.isIOS) ...[
                  _space(),
                  SizedBox(
                    width: double.infinity,
                    child: AMButton(
                      child: Text(i18n(context, "download")),
                      onPressed: () {
                        bloc.add(DownloadKeys([pgpKey]));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
                _space(),
                SizedBox(
                  width: double.infinity,
                  child: AMButton(
                    child: Text(i18n(context, "delete")),
                    onPressed: () async {
                      final result = await ConfirmationDialog.show(
                          context,
                          "",
                          i18n(context, "delete_user_key_confirm",
                              {"user": pgpKey.mail}),
                          "delete");
                      if (result == true) {
                        bloc.add(DeleteKey(pgpKey));
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                _space(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _space() {
    return SizedBox(
      height: 10,
    );
  }
}
