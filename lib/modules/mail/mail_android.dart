import 'package:animated_stream_list/animated_stream_list.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/loading_enum.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/mail/components/mail_app_bar.dart';
import 'package:aurora_mail/modules/mail/components/message_item.dart';
import 'package:aurora_mail/shared_ui/main_drawer.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'state/mail_state.dart';

class MailAndroid extends StatefulWidget {
  final Folder selectedFolder;

  const MailAndroid(this.selectedFolder);

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
    if (widget.selectedFolder == null) {
      await _foldersState.onGetFolders(onError: _showSnack);
      _mailState.onSetMessagesInfoToFolder(
          _foldersState.selectedFolder, onError: _showSnack);
    } else {
      _mailState.onSetMessagesInfoToFolder(
          widget.selectedFolder, onError: _showSnack);
      await Future.delayed(Duration(milliseconds: 10));
      _foldersState.selectedFolder = widget.selectedFolder;
    }
  }

  void _showSnack(err) {
    showSnack(
      context: context,
      scaffoldState: _mailState.scaffoldKey.currentState,
      msg: err.toString(),
    );
  }

  Widget _itemBuilder(Message item, int index, BuildContext context,
      Animation<double> animation) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: MessageItem(item),
    );
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
      body: Observer(
        builder: (_) {
          if (_foldersState.isFoldersLoading == LoadingType.hidden ||
              _mailState.isMessagesLoading == LoadingType.hidden || _foldersState.selectedFolder == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return AnimatedStreamList(
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 8.0, bottom: 76.0),
              streamList: _mailState.onWatchMessages(),
              itemBuilder: _itemBuilder,
              itemRemovedBuilder: _itemBuilder,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.emailPlusOutline),
        onPressed: () {},
      ),
    );
  }
}
