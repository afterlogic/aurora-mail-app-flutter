import 'dart:async';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_types.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_route.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/main_drawer.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_main_route.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'components/mail_app_bar.dart';
import 'components/message_item.dart';

class MessagesListAndroid extends StatefulWidget {
  @override
  _MessagesListAndroidState createState() => _MessagesListAndroidState();
}

class _MessagesListAndroidState extends State<MessagesListAndroid> {
  final _messagesListBloc = new MessagesListBloc();
  final _mailBloc = new MailBloc();

  var _refreshCompleter = new Completer();
  Folder _selectedFolder;

  Timer _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mailBloc.add(FetchFolders());
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _messagesListBloc.close();
    _mailBloc.close();
  }

  void _showError(BuildContext ctx, String err) {
    showSnack(context: ctx, scaffoldState: Scaffold.of(ctx), msg: err);
  }

  void _initUpdateTimer(int frequency, BuildContext context) async {
    final freq = SyncFreq.secondsToFreq(frequency);
    final syncDuration = SyncFreq.freqToDuration(freq);

    _timer?.cancel();
    _timer = Timer.periodic(
      syncDuration,
      (Timer timer) => _mailBloc.add(RefreshMessages()),
    );
  }

  void _onAppBarActionSelected(MailListAppBarAction item) {
    switch (item) {
      case MailListAppBarAction.logout:
        BlocProvider.of<AuthBloc>(context).add(LogOut());
        Navigator.pushReplacementNamed(context, LoginRoute.name);
        break;
      case MailListAppBarAction.settings:
        Navigator.pushNamed(context, SettingsMainRoute.name);
        break;
    }
  }

  void _onMessageSelected(List<Message> allMessages, Message item) {
    final i = allMessages.indexOf(item);

    final draftsFolder = (_mailBloc.state as FoldersLoaded).folders.firstWhere(
        (f) => f.folderType == FolderType.drafts,
        orElse: () => null);

    if (draftsFolder != null && item.folder == draftsFolder.fullNameRaw) {
      Navigator.pushNamed(
        context,
        ComposeRoute.name,
        arguments: ComposeScreenArgs(
          bloc: _mailBloc,
          message: item,
          draftUid: item.uid,
          composeType: ComposeType.fromDrafts,
        ),
      );
    } else {
      Navigator.pushNamed(
        context,
        MessageViewRoute.name,
        arguments:
            MessageViewScreenArgs(allMessages, i, _mailBloc, _messagesListBloc),
      );
    }
  }

  void _deleteMessage(Message message) {
    _messagesListBloc.add(DeleteMessages([message]));
  }

  void _dispatchPostFoldersLoadedAction(FoldersLoaded state) {
    switch (state.postAction) {
      case PostFolderLoadedAction.subscribeToMessages:
        _messagesListBloc.add(SubscribeToMessages(
            state.selectedFolder, state.isStarredFilterEnabled));
        break;
      case PostFolderLoadedAction.stopMessagesRefresh:
        _messagesListBloc.add(StopMessagesRefresh());
        break;
    }
  }

  void _setStarred(Message message, bool isStarred) {
    _mailBloc.add(SetStarred([message], isStarred));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MessagesListBloc>.value(
          value: _messagesListBloc,
        ),
        BlocProvider<MailBloc>.value(
          value: _mailBloc,
        ),
      ],
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(APP_BAR_HEIGHT_ANDROID),
          child: MailAppBar(onActionSelected: _onAppBarActionSelected),
        ),
        drawer: MainDrawer(),
        body: MultiBlocListener(
          listeners: [
            BlocListener(
              bloc: _messagesListBloc,
              listener: (BuildContext context, state) {
                if (state is MessagesRefreshed || state is MailError) {
                  _refreshCompleter?.complete();
                  _refreshCompleter = new Completer();
                }
                if (state is MessagesDeleted) _mailBloc.add(RefreshMessages());
                if (state is MailError) _showError(context, state.errorMsg);
              },
            ),
            BlocListener(
              bloc: _mailBloc,
              listener: (BuildContext context, state) {
                if (state is FoldersLoaded) {
                  setState(() => _selectedFolder = state.selectedFolder);
                  if (state.postAction != null) {
                    _dispatchPostFoldersLoadedAction(state);
                  }
                }
              },
            ),
            BlocListener<SettingsBloc, SettingsState>(
              condition: (prev, next) {
                if (prev is SettingsLoaded && next is SettingsLoaded && prev.darkThemeEnabled != next.darkThemeEnabled) {
                  return false;
                } else {
                  return true;
                }
              },
              listener: (BuildContext context, state) {
                if (state is SettingsLoaded) {
                  if (state.syncFrequency != null) {
                    _initUpdateTimer(state.syncFrequency, context);
                  }
                  _mailBloc.add(RefreshMessages());
                }
              },
            ),
          ],
          child: RefreshIndicator(
            onRefresh: () {
              _mailBloc.add(RefreshMessages());
              return _refreshCompleter.future;
            },
            backgroundColor: Colors.white,
            child: BlocBuilder<MessagesListBloc, MessagesListState>(
                bloc: _messagesListBloc,
                condition: (prevState, state) => state is SubscribedToMessages,
                builder: (context, state) {
                  if (state is SubscribedToMessages) {
                    return _buildMessagesStream(
                        state.messagesSub, state.isStarredFilterEnabled);
                  } else {
                    return _buildMessagesLoading();
                  }
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(MdiIcons.emailPlusOutline),
          onPressed: () => Navigator.pushNamed(context, ComposeRoute.name,
              arguments: ComposeScreenArgs(
                  bloc: _mailBloc, composeType: ComposeType.none)),
        ),
      ),
    );
  }

  Widget _buildMessagesLoading() => Center(child: CircularProgressIndicator());

  Widget _buildMessagesStream(
      Stream<List<Message>> messagesSub, bool isStarred) {
    return StreamBuilder(
      stream: messagesSub,
      builder: (ctx, AsyncSnapshot<List<Message>> snap) {
        if (snap.connectionState == ConnectionState.active) {
          if (snap.hasError) {
            _showError(ctx, snap.error.toString());
            return ListView();
          } else if (snap.hasData && snap.data.isNotEmpty) {
            // isStared shows FLAT structure
            List<Message> messages = snap.data;
            List<Message> threads = [];

            if (!isStarred) {
              messages = snap.data.where((m) => m.parentUid == null).toList();
              threads = snap.data.where((m) => m.parentUid != null).toList();
            }
            return ListView.separated(
              padding: EdgeInsets.only(top: 6.0, bottom: 76.0),
              itemCount: messages.length,
              itemBuilder: (_, i) {
                final item = messages[i];
                return Column(
                  children: <Widget>[
                    MessageItem(
                      item,
                      threads.where((t) => t.parentUid == item.uid).toList(),
                      key: Key(item.localId.toString()),
                      onItemSelected: (Message item) =>
                          _onMessageSelected(snap.data, item),
                      onStarMessage: _setStarred,
                      onDeleteMessage: _deleteMessage,
                    ),
                    if (_selectedFolder != null &&
                        _selectedFolder.needsInfoUpdate &&
                        i == messages.length - 1)
                      CircularProgressIndicator(),
                  ],
                );
              },
              separatorBuilder: (_, i) => Divider(
                height: 0.0,
                indent: 16.0,
                endIndent: 16.0,
              ),
            );
          } else {
            // build list view to be able to swipe to refresh
            if (_selectedFolder != null && _selectedFolder.needsInfoUpdate) {
              return _buildMessagesLoading();
            }
            return ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 68.0, horizontal: 16.0),
                  child: Center(child: Text(S.of(context).messages_empty)),
                ),
              ],
            );
          }
        } else {
          return _buildMessagesLoading();
        }
      },
    );
  }
}
