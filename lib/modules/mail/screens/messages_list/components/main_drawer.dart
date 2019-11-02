import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mail_folder.dart';

class MainDrawer extends StatefulWidget {
  final FoldersLoaded cachedState;

  const MainDrawer(this.cachedState);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
//  final _state = AppStore.foldersState;
  final _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  // TODO VO:
  void _showRefresh() => _refreshIndicatorKey.currentState.show();

  void _hideRefresh() => _refreshIndicatorKey.currentState.deactivate();

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
              child: BlocListener(
                bloc: BlocProvider.of<MailBloc>(context),
                listener: (BuildContext context, state) {
//                  if (state is FoldersLoading) _showRefresh();
//                  if (state is FoldersLoaded) _hideRefresh();
                },
                child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () async =>
                      BlocProvider.of<MailBloc>(context).add(RefreshFolders()),
                  child: BlocBuilder<MailBloc, MailState>(
                      bloc: BlocProvider.of<MailBloc>(context),
                      condition: (prevState, state) =>
                          state is FoldersLoaded || state is FoldersEmpty,
                      builder: (ctx, state) {
                        if (state is FoldersLoaded) {
                          return _buildFolders(state);
                        } else if (state is FoldersLoading) {
                          return _buildFoldersEmpty();
                        } else {
                          return _buildFolders(widget.cachedState);
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
    final items =
        _getFolderWidgets(state.folders, state.selectedFolder?.localId ?? -1);
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, i) => items[i],
    );
  }

  List<MailFolder> _getFolderWidgets(List<Folder> mailFolders, int selected,
      [String parentGuid]) {
    return mailFolders
        .where((f) => f.parentGuid == parentGuid)
        .map((mailFolder) {
      return MailFolder(
        mailFolder: mailFolder,
        isSelected: selected == mailFolder.localId,
        key: Key(mailFolder.localId.toString()),
        children: _getFolderWidgets(mailFolders, selected, mailFolder.guid),
      );
    }).toList();
  }

  Widget _buildFoldersEmpty() {
    // build list view to be able to swipe to refresh
    return ListView(
      key: PageStorageKey("my_key"),
      physics: AlwaysScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 68.0, horizontal: 16.0),
          // TODO translate
          child: Center(child: Text("No folders")),
        ),
      ],
    );
  }
}
