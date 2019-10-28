import 'package:aurora_mail/database/app_database.dart';
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
  @override
  _MailAndroidState createState() => _MailAndroidState();
}

class _MailAndroidState extends State<MailAndroid> {
  final _foldersState = AppStore.foldersState;
  final _mailState = new MailState();

  @override
  void initState() {
    super.initState();
    _foldersState.getFolders();
    _foldersState.onError = (err) => showSnack(
          context: context,
          scaffoldState: _mailState.scaffoldKey.currentState,
          msg: err.toString(),
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
          if (_foldersState.selectedFolder == null) {
            return Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () => _foldersState
                .setMessagesInfoToFolder(_foldersState.selectedFolder),
            child: StreamBuilder(
                stream:
                    _mailState.onWatchMessages(_foldersState.selectedFolder),
                builder: (_, AsyncSnapshot<List<Message>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data.isNotEmpty) {
                      return ListView.separated(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0, bottom: 76.0),
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, i) {
                          if (snapshot.data[i].parentUid == null) {
                            return MessageItem(snapshot.data[i]);
                          } else
                            return SizedBox();
                        },
                        separatorBuilder: (_, i) {
                          if (snapshot.data[i].parentUid == null) {
                            return Divider(height: 0.0);
                          } else
                            return SizedBox();
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      // TODO translate
                      return ListView(
                        physics: AlwaysScrollableScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 68.0, horizontal: 16.0),
                            child: Center(child: Text("No messages")),
                          ),
                        ],
                      );
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.emailPlusOutline),
        onPressed: () {},
      ),
    );
  }
}
