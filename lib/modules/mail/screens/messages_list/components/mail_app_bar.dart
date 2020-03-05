import 'dart:async';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/user_selection_popup.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MailAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MailAppBar();

  @override
  _MailAppBarState createState() => _MailAppBarState();

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}

class _MailAppBarState extends State<MailAppBar> {
  bool isSearchMode = false;
  Timer _debounce;

  void _getMessages(String val) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(Duration(milliseconds: val == null ? 0 : 500), () {
      final mailBloc = context.bloc<MailBloc>().state as FoldersLoaded;
      context.bloc<MessagesListBloc>().add(SubscribeToMessages(
            mailBloc.selectedFolder,
            mailBloc.isStarredFilterEnabled,
            val,
          ));
    });
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
      child: isSearchMode ? _buildSearchAppBar() : _buildDefaultAppBar(),
    );
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
            return Text(state.isStarredFilterEnabled
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
          onPressed: () => setState(() => isSearchMode = true),
        ),
        if (BuildProperty.multiUserEnable)
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (_, state) =>
                UserSelectionPopup((state as SettingsLoaded).users),
          ),
      ],
    );
  }

  Widget _buildSearchAppBar() {
    final theme = Theme.of(context).appBarTheme;
    return AMAppBar(
      key: Key("search_mail_app_bar"),
      leading: Icon(Icons.search),
      title: TextField(
        style: theme.textTheme.body1,
        autofocus: true,
        decoration: InputDecoration.collapsed(
          hintText: i18n(context, "messages_list_app_bar_search"),
          hintStyle: theme.textTheme.display1,
        ),
        onChanged: _getMessages,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() => isSearchMode = false);
            _getMessages(null);
          },
        ),
      ],
    );
  }
}
