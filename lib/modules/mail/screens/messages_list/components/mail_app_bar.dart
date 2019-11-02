import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/auth/auth_route.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      title: BlocBuilder<MailBloc, MailState>(
        bloc: BlocProvider.of<MailBloc>(context),
        condition: (_, state) =>
            state is FoldersLoaded ||
            state is FoldersLoading ||
            state is FoldersEmpty,
        builder: (_, state) {
          if (state is FoldersLoaded) {
            return Text(state.selectedFolder.name);
          } else if (state is FoldersLoading) {
            // TODO translate
            return Text("Loading folders...");
          } else if (state is FoldersEmpty) {
            // TODO translate
            return Text("No folders");
          } else {
            return Text("");
          }
        },
      ),
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
