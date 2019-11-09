import 'dart:async';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth/bloc.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_route.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/main_drawer.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_main_route.dart';
import 'package:aurora_mail/utils/show_snack.dart';
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
  final _mailBloc = new MailBloc();

  Completer<void> _refreshCompleter;

  // cache drawer state because when it's closed, the state is disposed
  FoldersLoaded _drawerInitialState = new FoldersLoaded([], null);

  Timer _timer;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _mailBloc.add(FetchFolders());
    _initUpdateTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _mailBloc.close();
  }

  void _showError(BuildContext ctx, String err) {
    showSnack(context: ctx, scaffoldState: Scaffold.of(ctx), msg: err);
  }

  void _initUpdateTimer() async {
    await Future.delayed(SYNC_PERIOD);
    _timer = Timer.periodic(
      SYNC_PERIOD,
      (Timer timer) => _mailBloc.add(CheckFoldersMessagesChanges()),
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MailBloc>.value(
      value: _mailBloc,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(APP_BAR_HEIGHT_ANDROID),
          child: MailAppBar(onActionSelected: _onAppBarActionSelected),
        ),
        drawer: MainDrawer(_drawerInitialState),
        body: BlocListener(
          bloc: _mailBloc,
          listener: (BuildContext context, state) {
            if (state is FoldersLoaded) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              setState(() => _drawerInitialState = state);
            }
            if (state is MailError) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              _showError(context, state.error);
            }
          },
          child: RefreshIndicator(
            onRefresh: () {
              _mailBloc.add(RefreshMessages());
              return _refreshCompleter.future;
            },
            child: BlocBuilder<MailBloc, MailState>(
                bloc: _mailBloc,
                condition: (prevState, state) => state is SubscribedToMessages,
                builder: (context, state) {
                  if (state is SubscribedToMessages) {
                    return _buildMessagesStream(state.messagesSub);
                  } else {
                    return _buildMessagesLoading();
                  }
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(MdiIcons.emailPlusOutline),
          onPressed: () => Navigator.pushNamed(context, ComposeRoute.name,
              arguments: ComposeScreenArgs(_mailBloc)),
        ),
      ),
    );
  }

  Widget _buildMessagesLoading() => Center(child: CircularProgressIndicator());

  Widget _buildMessagesStream(Stream<List<Message>> messagesSub) {
    return StreamBuilder(
      stream: messagesSub,
      builder: (ctx, AsyncSnapshot<List<Message>> snap) {
        if (snap.connectionState == ConnectionState.active) {
          if (snap.hasError) {
            _showError(ctx, snap.error.toString());
            return ListView();
          } else if (snap.hasData && snap.data.isNotEmpty) {
            final messagesWithoutChildren =
                snap.data.where((m) => m.parentUid == null).toList();

            return ListView.separated(
              padding: EdgeInsets.only(top: 6.0, bottom: 76.0),
              itemCount: messagesWithoutChildren.length,
              itemBuilder: (_, i) {
                final item = messagesWithoutChildren[i];
                return Column(
                  children: <Widget>[
                    InkWell(
                      child: MessageItem(item),
                      onTap: () => Navigator.pushNamed(
                        context,
                        MessageViewRoute.name,
                        arguments: MessageViewScreenArgs(
                            messagesWithoutChildren, i, _mailBloc),
                      ),
                    ),
                    if (_drawerInitialState.selectedFolder != null &&
                        _drawerInitialState.selectedFolder.needsInfoUpdate &&
                        i == messagesWithoutChildren.length - 1)
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
            if (_drawerInitialState.selectedFolder != null &&
                _drawerInitialState.selectedFolder.needsInfoUpdate) {
              return _buildMessagesLoading();
            }
            return ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 68.0, horizontal: 16.0),
                  // TODO translate
                  child: Center(child: Text("No messages")),
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
