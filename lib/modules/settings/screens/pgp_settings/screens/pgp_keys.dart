//@dart=2.9
import 'dart:io';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/repository/device_id_storage.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
  
import 'package:theme/app_color.dart';
import 'package:theme/app_theme.dart';

class PgpKeysScreen extends StatefulWidget {
  final List<PgpKey> pgpKeys;
  final PgpSettingsBloc bloc;

  const PgpKeysScreen(this.pgpKeys, this.bloc);

  @override
  _PgpKeysScreenState createState() => _PgpKeysScreenState();
}

class _PgpKeysScreenState extends State<PgpKeysScreen> {
  PgpSettingsBloc bloc;
  bool isAndroid9orLow;

  @override
  void initState() {
    super.initState();
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
      appBar: isTablet
          ? null
          : AMAppBar(
              title: Text(
                S.of(context).label_pgp_all_public_key,
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
                          S.of(context).label_pgp_all_public_key,
                          style: theme.textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                SelectableText(
                    widget.pgpKeys.map((key) => key.key).join("\n\n")),
              ],
            ),
          ),
          _button(context),
        ],
      ),
    );
  }

  Widget _button(BuildContext context) {
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
        shadow: AppColor.enableShadow ? null : BoxShadow(),
        child: Text(S.of(context).btn_php_send_all,
            style: TextStyle(color: Colors.white)),
        onPressed: () {
          bloc.add(ShareKeys(
            widget.pgpKeys,
            Rect.fromCenter(
              center: MediaQuery.of(context).size.bottomCenter(Offset.zero),
              width: 0,
              height: 0,
            ),
          ));
        },
      ),
      space,
      if (isAndroid9orLow)
        AMButton(
          color: Theme.of(context).primaryColor,
          shadow: AppColor.enableShadow ? null : BoxShadow(),
          child: Text(
            S.of(context).btn_pgp_download_all,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            bloc.add(DownloadKeys(widget.pgpKeys));
            Navigator.pop(context);
          },
        ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: isTablet
          ? Wrap(
              spacing: 10,
              runSpacing: 10,
              children: children,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
    );
  }

  Widget _space() {
    return SizedBox(
      height: 10,
    );
  }
}
