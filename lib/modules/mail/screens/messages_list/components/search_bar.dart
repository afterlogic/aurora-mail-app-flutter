import 'dart:async';

import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_state.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_event.dart';
import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatefulWidget {
  final Function onCancel;
  final TextEditingController searchCtrl;

  const SearchBar(this.searchCtrl, this.onCancel, {Key key}) : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends BState<SearchBar> {
  MailBloc mailBloc;
  MessagesListBloc messagesListBloc;
  Timer debounce;

  @override
  void initState() {
    super.initState();

    if (widget.searchCtrl.text.isNotEmpty) {
      _getMessages(widget.searchCtrl.text);
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
      _search(val);
    });
  }

  void _search(String val) {
    final mailState = mailBloc.state as FoldersLoaded;
    final params = searchUtil.searchParams(val);
    messagesListBloc.add(
      SubscribeToMessages(mailState.selectedFolder, mailState.filter, params),
    );
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
        decoration: InputDecoration.collapsed(
          hintText: i18n(context, "messages_list_app_bar_search"),
          hintStyle: theme.textTheme.display1,
        ),
        onChanged: _getMessages,
        controller: widget.searchCtrl,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() {
              widget.searchCtrl.clear();
              widget.onCancel();
            });
            _search(null);
          },
        ),
      ],
    );
  }

  search() {
    _search(widget.searchCtrl.text);
  }
}
