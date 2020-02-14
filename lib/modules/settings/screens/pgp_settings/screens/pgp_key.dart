import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/shared_ui/app_button.dart';
import 'package:aurora_mail/utils/internationalization.dart';
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
      appBar: AppBar(
        title: Text(
          i18n(
            context,
            pgpKey.isPrivate ? "public_key" : "private_key",
          ),
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
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    text: i18n(context, "share"),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    text: i18n(context, "download"),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    text: i18n(context, "delete"),
                    onPressed: () {
                      bloc.add(DeleteKey(pgpKey));
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
