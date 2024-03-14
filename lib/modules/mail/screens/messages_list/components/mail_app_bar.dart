//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/l10n.dart';
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
import 'package:aurora_mail/utils/base_state.dart';
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
  MailBloc _mailBloc;
  MessagesListBloc _messagesListBloc;
  TextEditingController _searchCtrl;
  bool isSelectMode = false;
  bool _isSearchMode = false;

  bool get isSearchMode => _isSearchMode;

  void set isSearchMode(bool value) {
    _isSearchMode = value;
    widget.onSearch(value);
  }

  String get searchText => _searchCtrl?.text;

  @override
  void initState() {
    super.initState();
    _mailBloc = BlocProvider.of<MailBloc>(context);
    _messagesListBloc = BlocProvider.of<MessagesListBloc>(context);
    final prevSearchText = _messagesListBloc.searchText;
    final search = widget.initSearch ?? prevSearchText;
    _searchCtrl = TextEditingController(text: search);
    if (search.isNotEmpty) {
      _isSearchMode = true;
    }
    widget.selectionController.addListener(onSelect);
  }

  @override
  void dispose() {
    super.dispose();
    widget.selectionController.removeListener(onSelect);
  }

  void onSelect() {
    if (widget.selectionController.enable != isSelectMode) {
      isSelectMode = widget.selectionController.enable;
      setState(() {});
    }
  }

  void search(String text) {
    isSearchMode = true;
    _searchCtrl.text = text;
    _search(text);
    setState(() {});
  }

  String _getTitle(BuildContext context, Folder folder) {
    return folder.displayName(context);
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
                  _searchCtrl,
                  changeMode,
                  _search,
                  key: searchKey,
                  isAppBar: widget.isAppBar,
                )
              : _buildDefaultAppBar(),
    );
  }

  void _search(String searchText) {
    final mailState = _mailBloc.state;
    if (mailState is FoldersLoaded) {
      final searchParams = searchUtil.searchParams(searchText);
      _messagesListBloc.add(
        SubscribeToMessages(mailState.selectedFolder, mailState.filter,
            searchParams, searchText),
      );
    }
  }

  void changeMode() {
    _searchCtrl.clear();
    setState(() => isSearchMode = !isSearchMode);
  }

  Widget _buildDefaultAppBar() {
    final theme = Theme.of(context);
    if (!widget.isAppBar) {
      return Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: changeMode,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 28, top: 6),
                  child: Icon(
                    Icons.search,
                    color: theme.disabledColor,
                  ),
                ),
              ),
            ),
          ),
          if (BuildProperty.multiUserEnable)
            BlocBuilder<AuthBloc, AuthState>(
              builder: (_, state) =>
                  UserSelectionPopup(BlocProvider.of<AuthBloc>(context).users),
            ),
        ],
      );
    }
    return AMAppBar(
      key: Key("default_mail_app_bar"),
      title: BlocBuilder<MailBloc, MailState>(
        bloc: _mailBloc,
        buildWhen: (_, state) =>
            state is FoldersLoaded ||
            state is FoldersLoading ||
            state is FoldersEmpty,
        builder: (_, state) {
          if (state is FoldersLoaded) {
            return Text(state.filter == MessagesFilter.starred
                ? S.of(context).folders_starred
                : _getTitle(context, state.selectedFolder));
          } else if (state is FoldersLoading) {
            return Text(S.of(context).messages_list_app_bar_loading_folders);
          } else if (state is FoldersEmpty) {
            return Text(S.of(context).folders_empty);
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
