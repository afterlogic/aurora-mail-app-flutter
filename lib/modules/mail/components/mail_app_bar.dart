import 'package:aurora_mail/modules/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MailAppBar extends StatefulWidget {
  @override
  _MailAppBarState createState() => _MailAppBarState();
}

class _MailAppBarState extends State<MailAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Observer(
          builder: (_) {
            final folder = AppStore.foldersState.selectedFolder;
            return Text(folder == null ? "" : folder.name);
          }),
    );
  }
}
