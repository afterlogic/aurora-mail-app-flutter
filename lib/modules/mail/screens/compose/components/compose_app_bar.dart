import 'package:aurora_mail/modules/auth/blocs/auth/bloc.dart';
import 'package:flutter/material.dart';

enum ComposeAppBarAction {
  saveToDrafts,
  send,
  cancel,
}

class ComposeAppBar extends StatelessWidget {
  final Function(ComposeAppBarAction action) onAppBarActionSelected;

  const ComposeAppBar(this.onAppBarActionSelected, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          onAppBarActionSelected(ComposeAppBarAction.cancel);
          Navigator.pop(context);
        },
      ),
      title: PopupMenuButton(
        enabled: false,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
                child: Text(
              AuthBloc.currentAccount.email,
              style: TextStyle(fontSize: 14.0),
            )),
//            SizedBox(width: 4.0),
//            Icon(Icons.keyboard_arrow_down)
          ],
        ),
        itemBuilder: (_) => [],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () =>
              onAppBarActionSelected(ComposeAppBarAction.saveToDrafts),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () => onAppBarActionSelected(ComposeAppBarAction.send),
        ),
      ],
    );
  }
}
