import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/loading_enum.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/mail/components/mail_folder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final _state = AppStore.foldersState;

  List<MailFolder> _buildFolders() {
    List<MailFolder> widgets = new List<MailFolder>();

    void getWidgets(List<Folder> mailFolders) {
      mailFolders.forEach((mailFolder) {
        widgets.add(MailFolder(
          mailFolder: mailFolder,
          key: Key(mailFolder.localId.toString()),
        ));
        if (mailFolder.subFolders != null && mailFolder.subFolders.isNotEmpty) {
          getWidgets(mailFolder.subFolders);
        }
      });
    }

    getWidgets(_state.currentFolders);
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Vasil Sokolov",
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: 8.0),
                  Text("vasil@afterlogic.com"),
                ],
              ),
            ),
            Divider(height: 0.0),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () =>
                    _state.getFolders(loading: LoadingType.refresh),
                child: Observer(builder: (_) {
                  if (_state.isFoldersLoading == LoadingType.hidden) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final items = _buildFolders();
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (_, i) => items[i],
                    );
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
