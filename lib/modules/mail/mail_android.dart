import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/mail/components/mail_app_bar.dart';
import 'package:aurora_mail/shared_ui/main_drawer.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'state/mail_state.dart';

class MailAndroid extends StatefulWidget {
  @override
  _MailAndroidState createState() => _MailAndroidState();
}

class _MailAndroidState extends State<MailAndroid> {
  final _foldersState = AppStore.foldersState;
  final _mailState = new MailState();

  @override
  void initState() {
    super.initState();
    _initMail();
  }

  Future<void> _initMail() async {
    await _foldersState.onGetFolders(
        onError: (err) => showSnack(
              context: context,
              scaffoldState: _mailState.scaffoldKey.currentState,
              msg: err.toString(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _mailState.scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: MailAppBar(),
      ),
      drawer: MainDrawer(),
      body: Placeholder(),
      floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.emailPlusOutline),
        onPressed: () {},
      ),
    );
  }
}
