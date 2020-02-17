import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/message_view_bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/message_view_state.dart';
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

class _MailBottomBarState extends State<MailBottomBar> {
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

        return AnimatedContainer(
          height: (encryptType == EncryptType.None || decrypted)
              ? 0
              : kToolbarHeight,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed:
                    decrypted ? null : () => widget.onDecrypt(encryptType),
                icon: Icon(
                  encryptType == EncryptType.Sign
                      ? (decrypted ? Icons.favorite : Icons.favorite_border)
                      : (decrypted ? Icons.lock_open : Icons.lock_outline),
                ),
              ),
            ],
          ),
          duration: Duration(milliseconds: 400),
        );
      },
    );
  }
}
