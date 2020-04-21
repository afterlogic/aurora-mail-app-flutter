import 'dart:io';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/modules/mail/blocs/compose_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/compose_bloc/compose_bloc.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ComposeBottomBar extends StatelessWidget {
  final VoidCallback onEncrypt;
  final VoidCallback onCreateSelfDestructingEmail;
  final VoidCallback onBack;
  final EncryptType encryptType;

  ComposeBottomBar(
    this.onEncrypt,
    this.onBack,
    this.onCreateSelfDestructingEmail,
    this.encryptType,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUndo =
        [EncryptType.Encrypt, EncryptType.Sign].contains(encryptType);
    final notEncrypt = encryptType == EncryptType.None;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: theme.dividerColor, width: 0),
        ),
      ),
      height: (Platform.isIOS ? kToolbarHeight + 15 : kToolbarHeight),
      padding: EdgeInsets.only(bottom: Platform.isIOS ? 15 : 0),
      width: double.infinity,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          if (isUndo)
            Flexible(
              child: Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onBack(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.arrow_back),
                      Text(i18n(context, "btn_pgp_undo_pgp")),
                    ],
                  ),
                ),
              ),
            ),
          if (!isUndo && BuildProperty.selfDestructingEmail)
            Flexible(
              child: Center(
                child: Opacity(
                  opacity: notEncrypt ? 1 : 0.7,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => encryptType == EncryptType.None
                        ? onCreateSelfDestructingEmail()
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(MdiIcons.clockAlertOutline),
                        Text(i18n(context, "btn_self_destructing")),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (!isUndo)
            Flexible(
              child: Center(
                child: Opacity(
                  opacity: notEncrypt ? 1 : 0.7,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () =>
                        encryptType == EncryptType.None ? onEncrypt() : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.lock_outline),
                        Text(i18n(context, "btn_pgp_encrypt")),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
