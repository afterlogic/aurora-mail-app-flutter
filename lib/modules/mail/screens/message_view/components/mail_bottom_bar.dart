import 'dart:io';

import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/message_view_bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/message_view_state.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MailBottomBar extends StatefulWidget {
  final void Function(EncryptType) onDecrypt;

  MailBottomBar({this.onDecrypt});

  @override
  _MailBottomBarState createState() => _MailBottomBarState();
}

class _MailBottomBarState extends BState<MailBottomBar> {
  EncryptType encryptType = EncryptType.None;
  bool decrypted = false;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MessageViewBloc>(context);
    return BlocBuilder<MessageViewBloc, MessageViewState>(
      bloc: bloc,
      condition: (_, next) {
        return next is DecryptComplete || next is MessageIsEncrypt;
      },
      builder: (context, state) {
        decrypted = state is DecryptComplete;
        if (state is MessageIsEncrypt) {
          encryptType = state.encryptType;
        }

        if (encryptType == EncryptType.None) {
          return SizedBox.shrink();
        }
        return Container(
          height: (Platform.isIOS ? kToolbarHeight + 15 : kToolbarHeight),
          padding: EdgeInsets.only(bottom: Platform.isIOS ? 15 : 0),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Opacity(
                opacity: decrypted ? 0.5 : 1,
                child: InkWell(
                  onTap: decrypted ? null : () => widget.onDecrypt(encryptType),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        encryptType == EncryptType.Sign
                            ? (decrypted
                                ? Icons.favorite
                                : Icons.favorite_border)
                            : (decrypted
                                ? Icons.lock_open
                                : Icons.lock_outline),
                      ),
                      Text(
                        i18n(
                            context,
                            encryptType == EncryptType.Sign
                                ? "verify_sign"
                                : "decrypt"),
                      ),
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
