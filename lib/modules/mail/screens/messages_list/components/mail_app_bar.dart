import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MailListAppBarAction { logout, settings }

class MailAppBar extends StatelessWidget {
  final Function(MailListAppBarAction) onActionSelected;

  const MailAppBar({Key key, this.onActionSelected}) : super(key: key);

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
          onSelected: onActionSelected,
          itemBuilder: (_) {
            return [
              // TODO translate
              PopupMenuItem(
                value: MailListAppBarAction.settings,
                child: Text("Settings"),
              ),
              PopupMenuItem(
                value: MailListAppBarAction.logout,
                child: Text("Log out"),
              ),
            ];
          },
        )
      ],
    );
  }
}
