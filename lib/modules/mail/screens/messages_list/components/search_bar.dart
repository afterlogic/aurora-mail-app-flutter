//@dart=2.9
import 'dart:async';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function onCancel;
  final TextEditingController searchCtrl;
  final Function(String) onSearch;
  final bool isAppBar;

  const SearchBar(
    this.searchCtrl,
    this.onCancel,
    this.onSearch, {
    Key key,
    this.isAppBar = true,
  }) : super(key: key);

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
    if (!widget.isAppBar) {
      return SizedBox(
        height: 50,
        width: double.infinity,
        child: ListTile(
          key: Key("search_mail_app_bar"),
          leading: IconButton(onPressed: null, icon: Icon(Icons.search)),
          title: TextField(
            autofocus: true,
            decoration: InputDecoration.collapsed(
              hintText: S.of(context).messages_list_app_bar_search,
            ),
            textInputAction: TextInputAction.search,
            onChanged: _getMessages,
            controller: widget.searchCtrl,
          ),
          trailing: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                widget.searchCtrl.clear();
                widget.onCancel();
              });
              widget.onSearch(null);
            },
          ),
        ),
      );
    } else {
      return AMAppBar(
        key: Key("search_mail_app_bar"),
        leading: Icon(Icons.search),
        title: TextField(
          style: theme.titleTextStyle,
          autofocus: true,
          decoration: InputDecoration.collapsed(
            hintText: S.of(context).messages_list_app_bar_search,
            hintStyle: theme.toolbarTextStyle,
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
}
