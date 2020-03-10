import 'dart:async';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/starred_folder.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mail_folder.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends BState<MainDrawer> {
  var _refreshCompleter = new Completer();
  _DrawerMode mode = _DrawerMode.folders;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    final multiAccountEnable = BuildProperty.multiAccountEnable;

    return Drawer(
      child: ListTileTheme(
        style: ListTileStyle.drawer,
        selectedColor: theme.accentColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: multiAccountEnable
                    ? () {
                        _changeMode();
                      }
                    : null,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          authBloc.currentAccount.friendlyName,
                          style: theme.textTheme.title,
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: <Widget>[
                            Text(authBloc.currentAccount.email),
                            if (multiAccountEnable)
                              Icon(mode == _DrawerMode.folders
                                  ? Icons.arrow_drop_down
                                  : Icons.arrow_drop_up),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(height: 0.0),
              if (mode == _DrawerMode.accounts)
                Expanded(
                  child: BlocBuilder<AuthBloc, AuthState>(
                    condition: (_, state) {
                      return state is InitializedUserAndAccounts;
                    },
                    builder: (BuildContext context, AuthState state) {
                      if (state is InitializedUserAndAccounts) {
                        return _buildAccounts(
                          state.account,
                          state.accounts,
                          authBloc,
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ),
              if (mode == _DrawerMode.folders)
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
                        BlocProvider.of<MailBloc>(context)
                            .add(RefreshFolders(true));
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
      ),
    );
  }

  Widget _buildAccounts(
      Account current, List<Account> accounts, AuthBloc authBloc) {
    final _accounts =
        accounts.where((item) => item.email != current.email).toList();
    return ListView.builder(
      itemCount: _accounts.length,
      itemBuilder: (_, i) {
        final account = _accounts[i];
        return InkWell(
          onTap: () {
            _changeMode();
            authBloc.add(ChangeAccount(account));
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(account.email),
          ),
        );
      },
    );
  }

  void _changeMode() {
    if (mode == _DrawerMode.accounts) {
      mode = _DrawerMode.folders;
    } else if (mode == _DrawerMode.folders) {
      mode = _DrawerMode.accounts;
    } else {
      return;
    }
    setState(() {});
  }

  Widget _buildFolders(FoldersLoaded state) {
    final items = _getFolderWidgets(
      state.folders,
      state.selectedFolder?.guid ?? "",
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
      List<Folder> mailFolders, String selected, bool isStarredFilterEnabled,
      [String parentGuid]) {
    return mailFolders.map((mailFolder) {
      return MailFolder(
        mailFolder: mailFolder,
        isSelected: selected == mailFolder.guid && !isStarredFilterEnabled,
        key: Key(mailFolder.guid),
      );
    }).toList();
  }

  Widget _buildFoldersEmpty() {
    return AMEmptyList(message: i18n(context, "folders_empty"));
  }

  Widget _buildFoldersLoading() {
    // build list view to be able to swipe to refresh
    return Center(child: CircularProgressIndicator());
  }
}

enum _DrawerMode { folders, accounts }
