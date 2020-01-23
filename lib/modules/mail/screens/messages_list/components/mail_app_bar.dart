import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/user_selection_popup.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MailAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const MailAppBar();

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
                ? i18n(context, "folders_starred")
                : state.selectedFolder.name);
          } else if (state is FoldersLoading) {
            return Text(i18n(context, "messages_list_app_bar_loading_folders"));
          } else if (state is FoldersEmpty) {
            return Text(i18n(context, "folders_empty"));
          } else {
            return SizedBox();
          }
        },
      ),
      actions: <Widget>[
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (_, state) => UserSelectionPopup((state as SettingsLoaded).users),
        ),
      ],
    );
  }
}
