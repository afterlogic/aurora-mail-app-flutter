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
    final bloc = BlocProvider.of<ComposeBloc>(context);
    return BlocBuilder<ComposeBloc, ComposeState>(
      bloc: bloc,
      condition: (_, next) {
        return next is EncryptComplete;
      },
      builder: (context, state) {
        final encrypted = state is EncryptComplete;
        return AnimatedContainer(
          height: encrypted ? 0 : kToolbarHeight,
          duration: Duration(milliseconds: 400),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
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
            ],
          ),
        );
      },
    );
  }
}
