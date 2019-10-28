import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/auth/auth_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

enum MailAppBarPopupItems {
  logout,
}

class MailAppBar extends StatefulWidget {
  @override
  _MailAppBarState createState() => _MailAppBarState();
}

class _MailAppBarState extends State<MailAppBar> {

  void _onPopupMenuItemSelected(MailAppBarPopupItems item) {
    switch (item) {
      case MailAppBarPopupItems.logout:
        AppStore.authState.onLogout();
        Navigator.pushReplacementNamed(context, AuthRoute.name);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Observer(builder: (_) {
        final folder = AppStore.foldersState.selectedFolder;
        return Text(folder == null ? "" : folder.name);
      }),
      actions: <Widget>[
        PopupMenuButton(
          onSelected: _onPopupMenuItemSelected,
          itemBuilder: (_) {
            return [
              PopupMenuItem(
                value: MailAppBarPopupItems.logout,
                child: Text("Log out"),
              )
            ];
          },
        )
      ],
    );
  }
}
