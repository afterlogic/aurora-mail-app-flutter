import 'dart:io';

import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PgpKeysScreen extends StatefulWidget {
  final List<PgpKey> pgpKeys;

  const PgpKeysScreen(
    this.pgpKeys,
  );

  @override
  _PgpKeysScreenState createState() => _PgpKeysScreenState();
}

class _PgpKeysScreenState extends State<PgpKeysScreen> {
  PgpSettingsBloc bloc;

  @override
  void initState() {
    bloc = AppInjector.instance.pgpSettingsBloc(BlocProvider.of<AuthBloc>(context));
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
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
              title: Text(i18n(
                context,
                S.label_pgp_all_public_key,
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
                            S.label_pgp_all_public_key,
                          ),
                          style: theme.textTheme.title,
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                SelectableText(widget.pgpKeys.map((key) => key.key).join("\n\n")),
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
        child: Text(i18n(context, S.btn_php_send_all)),
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
      if (!Platform.isIOS)
        AMButton(
          child: Text(i18n(context, S.btn_pgp_download_all)),
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
