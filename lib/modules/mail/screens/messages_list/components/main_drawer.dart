import 'dart:async';

import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/starred_folder.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:empty_list/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mail_folder.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  var _refreshCompleter = new Completer();

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
                    AuthBloc.currentAccount.friendlyName,
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: 8.0),
                  Text(AuthBloc.currentAccount.email),
                ],
              ),
            ),
            Divider(height: 0.0),
            Expanded(
              child: BlocListener(
                bloc: BlocProvider.of<MailBloc>(context),
                listener: (BuildContext context, state) {
                  if (state is FoldersLoaded || state is FoldersError) {
                    _refreshCompleter?.complete();
                    _refreshCompleter = new Completer();
                  }
                },
                child: RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<MailBloc>(context).add(RefreshFolders());
                    return _refreshCompleter.future;
                  },
                  backgroundColor: Colors.white,
                  color: Colors.black,
                  child: BlocBuilder<MailBloc, MailState>(
                      bloc: BlocProvider.of<MailBloc>(context),
                      condition: (prevState, state) =>
                          state is FoldersLoaded || state is FoldersEmpty,
                      builder: (ctx, state) {
                        if (state is FoldersLoaded) {
                          return _buildFolders(state);
                        } else if (state is FoldersLoading) {
                          return _buildFoldersLoading();
                        } else {
                          return _buildFoldersEmpty();
                        }
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFolders(FoldersLoaded state) {
    final items = _getFolderWidgets(
      state.folders,
      state.selectedFolder?.localId ?? -1,
      state.isStarredFilterEnabled,
    );
    final folderWidgets = new List<Widget>.from(items);

    final inboxFolder = state.folders.firstWhere(
        (f) => f.folderType == FolderType.inbox,
        orElse: () => null);
    if (inboxFolder != null) {
      folderWidgets.insert(
          1,
          StarredFolder(
            mailFolder: inboxFolder,
            isSelected: state.isStarredFilterEnabled,
          ));
    }
    return ListView.builder(
      itemCount: folderWidgets.length,
      itemBuilder: (_, i) => folderWidgets[i],
    );
  }

  List<MailFolder> _getFolderWidgets(
      List<Folder> mailFolders, int selected, bool isStarredFilterEnabled,
      [String parentGuid]) {
    return mailFolders
        .where((f) => f.parentGuid == parentGuid)
        .map((mailFolder) {
      return MailFolder(
        mailFolder: mailFolder,
        isSelected: selected == mailFolder.localId && !isStarredFilterEnabled,
        key: Key(mailFolder.localId.toString()),
        children: _getFolderWidgets(
            mailFolders, selected, isStarredFilterEnabled, mailFolder.guid),
      );
    }).toList();
  }

  Widget _buildFoldersEmpty() {
    return EmptyList(message: i18n(context, "folders_empty"));
  }

  Widget _buildFoldersLoading() {
    // build list view to be able to swipe to refresh
    return Center(child: CircularProgressIndicator());
  }
}
