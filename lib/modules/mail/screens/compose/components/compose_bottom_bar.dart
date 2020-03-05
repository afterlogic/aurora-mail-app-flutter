import 'dart:io';

import 'package:aurora_mail/modules/mail/blocs/compose_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/compose_bloc/compose_bloc.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComposeBottomBar extends StatefulWidget {
  final VoidCallback onEncrypt;

  ComposeBottomBar({this.onEncrypt});

  @override
  _ComposeBottomBarState createState() => _ComposeBottomBarState();
}

class _ComposeBottomBarState extends State<ComposeBottomBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = BlocProvider.of<ComposeBloc>(context);
    return BlocBuilder<ComposeBloc, ComposeState>(
      bloc: bloc,
      condition: (_, next) {
        return next is EncryptComplete;
      },
      builder: (context, state) {
        final encrypted = state is EncryptComplete;
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Opacity(
                opacity: encrypted ? 0.5 : 1,
                child: InkWell(
                  onTap: encrypted ? null : widget.onEncrypt,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.lock_outline),
                      Text(i18n(context, "encrypt")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
