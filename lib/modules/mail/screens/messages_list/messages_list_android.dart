import 'dart:async';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_route.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/main_drawer.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../bloc/bloc.dart';
import 'components/mail_app_bar.dart';
import 'components/message_item.dart';

class MessagesListAndroid extends StatefulWidget {
  @override
  _MessagesListAndroidState createState() => _MessagesListAndroidState();
}

class _MessagesListAndroidState extends State<MessagesListAndroid> {
//  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  final _mailBloc = new MailBloc();

  // cache drawer state because when it's closed, the state is disposed
  FoldersLoaded _drawerInitialState = new FoldersLoaded([], null);

  Timer _timer;

  @override
  void initState() {
    super.initState();
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

  void _showRefresh() => _refreshIndicatorKey.currentState.show();

  void _hideRefresh() => _refreshIndicatorKey.currentState.deactivate();

  void _initUpdateTimer() async {
    await Future.delayed(SYNC_PERIOD);
    _timer = Timer.periodic(
      SYNC_PERIOD,
      (Timer timer) => _mailBloc.add(CheckFoldersUpdateByTimer()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MailBloc>(
      builder: (_) => _mailBloc,
      child: Scaffold(
//        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(APP_BAR_HEIGHT_ANDROID),
          child: MailAppBar(),
        ),
        drawer: MainDrawer(_drawerInitialState),
        body: BlocListener(
          bloc: _mailBloc,
          listener: (BuildContext context, state) {
            if (state is FoldersLoaded) {
              setState(() => _drawerInitialState = state);
            }
            if (state is MailError) _showError(context, state.error);
//            if (state is MessagesSyncing) _showRefresh();
//            if (state is MessagesSynced) _hideRefresh();
          },
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async => _mailBloc.add(RefreshMessages()),
            child: BlocBuilder<MailBloc, MailState>(
                bloc: _mailBloc,
                condition: (prevState, state) =>
                    state is SubscribedToMessages || state is FoldersLoading,
                builder: (context, state) {
                  if (state is FoldersLoading) {
                    return _buildMessagesLoading();
                  } else if (state is SubscribedToMessages) {
                    return _buildMessagesStream(state.messagesSub);
                  } else {
                    return ListView();
                  }
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(MdiIcons.emailPlusOutline),
          onPressed: () {},
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
                return InkWell(
                  child: MessageItem(item),
                  onTap: () => Navigator.pushNamed(
                    context,
                    MessageViewRoute.name,
                    arguments:
                        MessageViewScreenArgs(messagesWithoutChildren, i),
                  ),
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

//            RefreshIndicator(
//                key: _refreshIndicatorKey,
//                onRefresh: () =>
//                    _foldersState.updateFoldersHash(forceCurrentFolderUpdate: true),
//                child: Stack(children: [
//                  Observer(
//                      builder: (_) => Positioned(
//                          top: 0.0,
//                          left: 0.0,
//                          right: 0.0,
//                          child: AnimatedOpacity(
//                            duration: Duration(milliseconds: 150),
//                            opacity: _foldersState.messagesLoading ==
//                                        LoadingType.visible &&
//                                    _mailState.messagesCount > 0
//                                ? 1.0
//                                : 0.0,
//                            child: LinearProgressIndicator(
//                              backgroundColor:
//                                  Theme.of(context).disabledColor.withOpacity(0.05),
//                            ),
//                          ))),
//                  Positioned.fill(
//                    child: StreamBuilder(
//                        stream: _mailState
//                            .onWatchMessages(_foldersState.selectedFolder),
//                        builder: (_, AsyncSnapshot<List<Message>> snapshot) {
//                          if (snapshot.connectionState == ConnectionState.active) {
//                            if (snapshot.hasData && snapshot.data.isNotEmpty) {
//                              return ListView.separated(
//                                padding: EdgeInsets.only(top: 6.0, bottom: 76.0),
//                                itemCount: snapshot.data.length,
//                                itemBuilder: (_, i) {
//                                  if (snapshot.data[i].parentUid == null) {
//                                    return Column(
//                                      children: <Widget>[
//                                        MessageItem(snapshot.data[i]),
////                                    if (i == snapshot.data.length - 1 &&
////                                        _foldersState.messagesLoading ==
////                                            LoadingType.visible)
////                                      CircularProgressIndicator()
//                                      ],
//                                    );
//                                  } else
//                                    return SizedBox();
//                                },
//                                separatorBuilder: (_, i) {
//                                  if (snapshot.data[i].parentUid == null) {
//                                    return Divider(
//                                      height: 0.0,
//                                      indent: 16.0,
//                                      endIndent: 16.0,
//                                    );
//                                  } else
//                                    return SizedBox();
//                                },
//                              );
//                            } else if (snapshot.hasData &&
//                                snapshot.data.isEmpty &&
//                                _foldersState.messagesLoading == LoadingType.none) {
//                              return ListView(
//                                physics: AlwaysScrollableScrollPhysics(),
//                                children: [
//                                  Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        vertical: 68.0, horizontal: 16.0),
//                                    // TODO translate
//                                    child: Center(child: Text("No messages")),
//                                  ),
//                                ],
//                              );
//                            } else if (snapshot.hasError) {
//                              return Center(child: Text(snapshot.error.toString()));
//                            } else {
//                              return Center(child: CircularProgressIndicator());
//                            }
//                          } else {
//                            return Center(child: CircularProgressIndicator());
//                          }
//                        }),
//                  ),
//                ]),
//              ),
