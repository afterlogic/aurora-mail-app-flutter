import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/search_bar.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/select_app_bar.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/selection_controller.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/user_selection_popup.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MailAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String initSearch;
  final SelectionController<int, Message> selectionController;
  final Function(bool value) onSearch;

  const MailAppBar({
    this.initSearch,
    this.selectionController,
    Key key,
    this.onSearch,
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
    searchKey.currentState.search();
    setState(() {});
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
      child: isSelectMode
          ? SelectAppBar(widget.selectionController)
          : isSearchMode
              ? SearchBar(searchCtrl, changeMode,key: searchKey,)
              : _buildDefaultAppBar(),
    );
  }

  changeMode() {
    searchCtrl.clear();
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
