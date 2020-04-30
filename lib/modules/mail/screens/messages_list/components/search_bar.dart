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
  final Function(String) onSearch;

  const SearchBar(this.searchCtrl, this.onCancel, this.onSearch, {Key key})
      : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends BState<SearchBar> {
  Timer debounce;

  @override
  void initState() {
    super.initState();

    if (widget.searchCtrl.text.isNotEmpty) {
      _getMessages(widget.searchCtrl.text);
    }
  }


  void _getMessages(String val) {
    if (debounce?.isActive == true) debounce.cancel();
    debounce = Timer(Duration(milliseconds: val == null ? 0 : 500), () {
      widget.onSearch(val);
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
            widget.onSearch(null);
          },
        ),
      ],
    );
  }
}
