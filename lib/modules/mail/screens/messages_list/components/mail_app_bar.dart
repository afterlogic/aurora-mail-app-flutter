import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_state.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/search_bar.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/select_app_bar.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/selection_controller.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/user_selection_popup.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MailAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String initSearch;
  final SelectionController<int, Message> selectionController;
  final Function(bool value) onSearch;
  final bool enable;
  final bool isAppBar;

  const MailAppBar({
    this.initSearch,
    this.selectionController,
    Key key,
    this.onSearch,
    this.enable = true,
    this.isAppBar = true,
  }) : super(key: key);

  @override
  MailAppBarState createState() => MailAppBarState();

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}

class MailAppBarState extends BState<MailAppBar> {
  final searchKey = GlobalKey<SearchBarState>();
  TextEditingController searchCtrl;
  bool _isSearchMode = false;

  bool get isSearchMode => _isSearchMode;

  String get searchText => searchCtrl?.text;

  set isSearchMode(bool value) {
    _isSearchMode = value;
    widget.onSearch(value);
  }

  bool isSelectMode = false;

  @override
  void initState() {
    searchCtrl = TextEditingController(text: widget.initSearch ?? "");
    if (widget.initSearch != null) {
      isSearchMode = true;
    }
    widget.selectionController.addListener(onSelect);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.selectionController.removeListener(onSelect);
  }

  onSelect() {
    if (widget.selectionController.enable != isSelectMode) {
      isSelectMode = widget.selectionController.enable;
      setState(() {});
    }
  }

  search(String text) {
    isSearchMode = true;
    searchCtrl.text = text;
    _search(text);
    setState(() {});
  }

  String _getTitle(BuildContext context, Folder folder) {
    switch (folder.folderType) {
      case FolderType.inbox:
        return i18n(context, S.folders_inbox);
      case FolderType.sent:
        return i18n(context, S.folders_sent);
      case FolderType.drafts:
        return i18n(context, S.folders_drafts);
      case FolderType.spam:
        return i18n(context, S.folders_spam);
      case FolderType.trash:
        return i18n(context, S.folders_trash);
      default:
        return folder.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enable) {
      return _buildDefaultAppBar();
    }
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 250),
      child: isSelectMode
          ? SelectAppBar(widget.selectionController, isAppBar: widget.isAppBar)
          : isSearchMode
              ? SearchBar(
                  searchCtrl,
                  changeMode,
                  _search,
                  key: searchKey,
                  isAppBar: widget.isAppBar,
                )
              : _buildDefaultAppBar(),
    );
  }

  _search(String val) {
    final mailState = BlocProvider.of<MailBloc>(context).state as FoldersLoaded;
    final params = searchUtil.searchParams(val);
    BlocProvider.of<MessagesListBloc>(context).add(
      SubscribeToMessages(mailState.selectedFolder, mailState.filter, params),
    );
  }

  changeMode() {
    searchCtrl.clear();
    setState(() => isSearchMode = !isSearchMode);
  }

  Widget _buildDefaultAppBar() {
    if (!widget.isAppBar) {
      return ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: changeMode,
            ),
            if (BuildProperty.multiUserEnable)
              BlocBuilder<AuthBloc, AuthState>(
                builder: (_, state) => UserSelectionPopup(
                    BlocProvider.of<AuthBloc>(context).users),
              ),
          ],
        ),
      );
    }
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
                ? i18n(context, S.folders_starred)
                : _getTitle(context, state.selectedFolder));
          } else if (state is FoldersLoading) {
            return Text(i18n(context, S.messages_list_app_bar_loading_folders));
          } else if (state is FoldersEmpty) {
            return Text(i18n(context, S.folders_empty));
          } else {
            return SizedBox();
          }
        },
      ),
      actions: widget.enable
          ? <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: changeMode,
              ),
              if (BuildProperty.multiUserEnable)
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (_, state) => UserSelectionPopup(
                      BlocProvider.of<AuthBloc>(context).users),
                ),
            ]
          : null,
    );
  }
}
