import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/search_bar.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/user_selection_popup.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MailAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String initSearch;

  const MailAppBar({this.initSearch});

  @override
  _MailAppBarState createState() => _MailAppBarState();

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}

class _MailAppBarState extends BState<MailAppBar> {
  bool isSearchMode = false;
  String initSearch;

  @override
  void initState() {
    initSearch = widget.initSearch;
    if (initSearch != null) {
      isSearchMode = true;
    }
    super.initState();
  }

  String _getTitle(BuildContext context, Folder folder) {
    switch (folder.folderType) {
      case FolderType.inbox:
        return i18n(context, "folders_inbox");
      case FolderType.sent:
        return i18n(context, "folders_sent");
      case FolderType.drafts:
        return i18n(context, "folders_drafts");
      case FolderType.spam:
        return i18n(context, "folders_spam");
      case FolderType.trash:
        return i18n(context, "folders_trash");
      default:
        return folder.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 250),
      child: isSearchMode
          ? SearchBar(initSearch, changeMode)
          : _buildDefaultAppBar(),
    );
  }

  changeMode() {
    initSearch = null;
    setState(() => isSearchMode = !isSearchMode);
  }

  Widget _buildDefaultAppBar() {
    return AMAppBar(
      key: Key("default_mail_app_bar"),
      title: BlocBuilder<MailBloc, MailState>(
        bloc: BlocProvider.of<MailBloc>(context),
        condition: (_, state) =>
            state is FoldersLoaded ||
            state is FoldersLoading ||
            state is FoldersEmpty,
        builder: (_, state) {
          if (state is FoldersLoaded) {
            return Text(state.filter == MessagesFilter.starred
                ? i18n(context, "folders_starred")
                : _getTitle(context, state.selectedFolder));
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
        IconButton(
          icon: Icon(Icons.search),
          onPressed: changeMode,
        ),
        if (BuildProperty.multiUserEnable)
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (_, state) =>
                UserSelectionPopup((state as SettingsLoaded).users),
          ),
      ],
    );
  }
}
