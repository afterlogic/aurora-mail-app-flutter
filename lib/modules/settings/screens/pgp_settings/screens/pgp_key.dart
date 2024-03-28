//@dart=2.9
import 'dart:io';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/repository/device_id_storage.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_navigator.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/material.dart';

class PgpKeyScreen extends StatefulWidget {
  final PgpSettingsBloc bloc;
  final PgpKey pgpKey;
  final Function() onDelete;
  final bool withAppBar;

  const PgpKeyScreen(this.pgpKey, this.onDelete, this.withAppBar, this.bloc);

  @override
  _PgpKeyScreenState createState() => _PgpKeyScreenState();
}

class _PgpKeyScreenState extends State<PgpKeyScreen> {
  PgpSettingsBloc bloc;
  PgpKey pgpKey;
  Function() onDelete;
  bool withAppBar;
  bool isAndroid9orLow;

  @override
  void initState() {
    super.initState();
    pgpKey = widget.pgpKey;
    onDelete = widget.onDelete;
    withAppBar = widget.withAppBar;
    bloc = widget.bloc;
    isAndroid9orLow = Platform.isAndroid;
    DeviceIdStorage.isAndroid10orHigh().then((value) {
      if (value) {
        setState(() {
          // TODO: deal with Android 10 file permissions
          // isAndroid9orLow = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = LayoutConfig.of(context).isTablet;
    return Scaffold(
      appBar: isTablet && !withAppBar
          ? null
          : AMAppBar(
              title: Text(
                pgpKey.isPrivate
                    ? S.of(context).label_pgp_private_key
                    : S.of(context).label_pgp_public_key,
              ),
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
                          pgpKey.isPrivate
                              ? S.of(context).label_pgp_private_key
                              : S.of(context).label_pgp_public_key,
                          style: theme.textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                Text(
                  pgpKey.formatName(),
                  style: theme.textTheme.headline6,
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
        color: Theme.of(context).primaryColor,
        child: Text(S.of(context).btn_share,
            style: TextStyle(color: Colors.white)),
        onPressed: () async {
          final result = pgpKey.isPrivate
              ? await ConfirmationDialog.show(
                  context,
                  S.of(context).label_pgp_share_warning,
                  S.of(context).hint_pgp_share_warning,
                  S.of(context).btn_share)
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
      if (isAndroid9orLow)
        AMButton(
          color: Theme.of(context).primaryColor,
          child: Text(S.of(context).btn_download,
              style: TextStyle(color: Colors.white)),
          onPressed: () {
            bloc.add(DownloadKeys([pgpKey]));
            SettingsNavigatorWidget.of(context).pop();
          },
        ),
      if (isAndroid9orLow) space,
      AMButton(
        color: Theme.of(context).primaryColor,
        child: Text(S.of(context).btn_delete,
            style: TextStyle(color: Colors.white)),
        onPressed: () async {
          final result = await ConfirmationDialog.show(
            context,
            "",
            S.of(context).hint_pgp_delete_user_key_confirm(pgpKey.mail),
            S.of(context).btn_delete,
          );
          if (result == true) {
            if (onDelete != null) {
              onDelete();
            } else {
              bloc.add(DeleteKey(pgpKey));
            }
            SettingsNavigatorWidget.of(context).pop();
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
