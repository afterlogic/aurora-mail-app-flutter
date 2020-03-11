import 'dart:async';

import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_state.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_event.dart';
import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatefulWidget {
  final Function onCancel;
  final String initSearch;

  const SearchBar(this.initSearch, this.onCancel);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends BState<SearchBar> {
  MailBloc mailBloc;
  MessagesListBloc messagesListBloc;
  Timer debounce;
  TextEditingController searchCtrl;

  @override
  void initState() {
    super.initState();
    searchCtrl = TextEditingController(text: widget.initSearch ?? "");
    if (widget.initSearch != null) {
      _getMessages(widget.initSearch);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mailBloc = BlocProvider.of<MailBloc>(context);
    messagesListBloc = BlocProvider.of<MessagesListBloc>(context);
  }

  void _getMessages(String val) {
    if (debounce?.isActive == true) debounce.cancel();
    debounce = Timer(Duration(milliseconds: val == null ? 0 : 500), () {
      final mailState = mailBloc.state as FoldersLoaded;
      final params = searchUtil.searchParams(val);
      messagesListBloc.add(SubscribeToMessages(
        mailState.selectedFolder,
        mailState.filter,
        params.value,
        params.pattern,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).appBarTheme;
    return AMAppBar(
      key: Key("search_mail_app_bar"),
      leading: Icon(Icons.search),
      title: TextField(
        style: theme.textTheme.body1,
        autofocus: true,
        decoration: InputDecoration(
          hintText: i18n(context, "messages_list_app_bar_search"),
          hintStyle: theme.textTheme.display1,
        ),
        onChanged: _getMessages,
        controller: searchCtrl,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() {
              _getMessages(null);
              searchCtrl.clear();
              widget.onCancel();
            });
            _getMessages(null);
          },
        ),
      ],
    );
  }
}
