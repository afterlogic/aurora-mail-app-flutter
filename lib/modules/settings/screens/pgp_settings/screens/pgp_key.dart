import 'dart:io';

import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PgpKeyScreen extends StatelessWidget {
  final PgpKey pgpKey;
  final PgpSettingsBloc bloc;
  final Function() onDelete;

  const PgpKeyScreen(this.pgpKey, this.bloc, this.onDelete);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AMAppBar(
        title: Text(i18n(
          context,
          pgpKey.isPrivate ? S.label_pgp_private_key : S.label_pgp_public_key,
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
                    pgpKey.formatName(),
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
                    child: Text(i18n(context, S.btn_share)),
                    onPressed: () async {
                      final result = pgpKey.isPrivate
                          ? await ConfirmationDialog.show(
                              context,
                              i18n(context, S.label_pgp_share_warning),
                              i18n(context, S.hint_pgp_share_warning),
                              i18n(context, S.btn_share))
                          : true;
                      if (result == true) {
                        bloc.add(ShareKeys([pgpKey]));
                      }
                    },
                  ),
                ),
                if (!Platform.isIOS) ...[
                  _space(),
                  SizedBox(
                    width: double.infinity,
                    child: AMButton(
                      child: Text(i18n(context, S.btn_download)),
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
                    child: Text(i18n(context, S.btn_delete)),
                    onPressed: () async {
                      final result = await ConfirmationDialog.show(
                        context,
                        "",
                        i18n(context, S.hint_pgp_delete_user_key_confirm,
                            {"user": pgpKey.mail}),
                        i18n(context, S.btn_delete),
                      );
                      if (result == true) {
                        if (onDelete != null) {
                          onDelete();
                        } else {
                          bloc.add(DeleteKey(pgpKey));
                        }
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
