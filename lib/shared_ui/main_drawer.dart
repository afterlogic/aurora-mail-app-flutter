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
            Divider(),
            Expanded(
              child: Observer(
                builder: (_) => _state.isFoldersLoading != LoadingType.none
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        itemCount: _state.currentFolders.length,
                        itemBuilder: (_, int i) {
                          final item = _state.currentFolders[i];
                          return MailFolder(
                            mailFolder: item,
                            key: Key(item.localId.toString()),
                          );
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
