import 'dart:io';

import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PgpKeyScreen extends StatelessWidget {
  final PgpSettingsBloc bloc;
  final PgpKey pgpKey;
  final Function() onDelete;
  final bool withAppBar;

  const PgpKeyScreen(this.pgpKey, this.onDelete, this.withAppBar, this.bloc);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = LayoutConfig.of(context).isTablet;
    return Scaffold(
      appBar: isTablet && !withAppBar
          ? null
          : AMAppBar(
              title: Text(i18n(
                context,
                pgpKey.isPrivate
                    ? S.label_pgp_private_key
                    : S.label_pgp_public_key,
              )),
            ),
      body: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: <Widget>[
                if (isTablet)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          i18n(
                            context,
                            pgpKey.isPrivate
                                ? S.label_pgp_private_key
                                : S.label_pgp_public_key,
                          ),
                          style: theme.textTheme.title,
                        ),
                      ),
                    ),
                  ),
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
          _buttons(context),
        ],
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    final isTablet = LayoutConfig.of(context).isTablet;
    final space = isTablet
        ? SizedBox.shrink()
        : SizedBox(
            height: 10.0,
            width: 10,
          );
    final children = <Widget>[
      AMButton(
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
            bloc.add(ShareKeys(
              [pgpKey],
              Rect.fromCenter(
                center: MediaQuery.of(context).size.bottomCenter(Offset.zero),
                width: 0,
                height: 0,
              ),
            ));
          }
        },
      ),
      space,
      if (!Platform.isIOS)
        Column(
          children: [
            AMButton(
              child: Text(i18n(context, S.btn_download)),
              onPressed: () {
                bloc.add(DownloadKeys([pgpKey]));
                Navigator.pop(context);
              },
            ),
            space,
          ],
        ),
      AMButton(
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
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: isTablet
          ? Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: children,
              ),
            )
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
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
