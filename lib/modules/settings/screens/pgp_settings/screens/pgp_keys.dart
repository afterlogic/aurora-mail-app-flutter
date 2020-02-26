import 'dart:io';

import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PgpKeysScreen extends StatelessWidget {
  final List<PgpKey> pgpKeys;
  final PgpSettingsBloc bloc;

  const PgpKeysScreen(this.pgpKeys, this.bloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          i18n(context, "all_public_key"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  SelectableText(pgpKeys.map((key) => key.key).join("\n\n")),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                _space(),
                SizedBox(
                  width: double.infinity,
                  child: AMButton(
                    child: Text(i18n(context, "send_all")),
                    onPressed: () {
                      bloc.add(ShareKeys(pgpKeys));
                    },
                  ),
                ),
                _space(),
                if (!Platform.isIOS) ...[
                  SizedBox(
                    width: double.infinity,
                    child: AMButton(
                      child: Text(i18n(context, "download_all")),
                      onPressed: () {
                        bloc.add(DownloadKeys(pgpKeys));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  _space(),
                ],
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
