import 'package:aurora_mail/modules/mail/blocs/compose_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/compose_bloc/compose_bloc.dart';
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
        return Container(
          height: kToolbarHeight,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed: encrypted ? null : widget.onEncrypt,
                icon: Icon(
                  encrypted ? Icons.lock_outline : Icons.lock_open,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
