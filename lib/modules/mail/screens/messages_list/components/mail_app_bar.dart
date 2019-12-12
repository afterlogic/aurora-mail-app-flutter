import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MailListAppBarAction { logout, settings, contacts }

class MailAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
 final Size  preferredSize = const Size.fromHeight(kToolbarHeight);

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
            return Text(state.isStarredFilterEnabled
                ? S.of(context).folders_starred
                : state.selectedFolder.name);
          } else if (state is FoldersLoading) {
            return Text(S.of(context).messages_list_app_bar_loading_folders);
          } else if (state is FoldersEmpty) {
            return Text(S.of(context).folders_empty);
          } else {
            return SizedBox();
          }
        },
      ),
      actions: <Widget>[
        PopupMenuButton(
          onSelected: onActionSelected,
          itemBuilder: (_) {
            return [
              PopupMenuItem(
                value: MailListAppBarAction.contacts,
                child: Text(S.of(context).messages_list_app_bar_contacts),
              ),
              PopupMenuItem(
                value: MailListAppBarAction.settings,
                child: Text(S.of(context).messages_list_app_bar_settings),
              ),
              PopupMenuItem(
                value: MailListAppBarAction.logout,
                child: Text(S.of(context).messages_list_app_bar_logout),
              ),
            ];
          },
        )
      ],
    );
  }
}
