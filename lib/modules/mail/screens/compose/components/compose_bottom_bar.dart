import 'dart:io';

import 'package:aurora_mail/modules/mail/blocs/compose_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/compose_bloc/compose_bloc.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ComposeBottomBar extends StatefulWidget {
  final VoidCallback onEncrypt;
  final VoidCallback onCreateSelfDestructingEmail;
  final VoidCallback onBack;

  ComposeBottomBar(
    this.onEncrypt,
    this.onBack,
    this.onCreateSelfDestructingEmail,
  );

  @override
  _ComposeBottomBarState createState() => _ComposeBottomBarState();
}

class _ComposeBottomBarState extends BState<ComposeBottomBar> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ComposeBloc>(context);
    return BlocBuilder<ComposeBloc, ComposeState>(
      bloc: bloc,
      condition: (_, next) {
        return next is EncryptComplete || next is DecryptedState;
      },
      builder: (context, state) {
        final encrypted =
            state is EncryptComplete ? state.type != EncryptType.None : false;
        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: theme.dividerColor, width: 0),
            ),
          ),
          height: (Platform.isIOS ? kToolbarHeight + 15 : kToolbarHeight),
          padding: EdgeInsets.only(bottom: Platform.isIOS ? 15 : 0),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () => encrypted
                    ? widget.onBack()
                    : widget.onCreateSelfDestructingEmail(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(MdiIcons.clockAlert),
                    Text("self-destructing"),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => encrypted ? widget.onBack() : widget.onEncrypt(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(encrypted ? Icons.lock_open : Icons.lock_outline),
                    Text(i18n(context, encrypted ? "decrypt" : "encrypt")),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
