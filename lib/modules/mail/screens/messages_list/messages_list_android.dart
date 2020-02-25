import 'dart:async';

import 'package:aurora_mail/background/background_helper.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_actions.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_route.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/main_drawer.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/shared_ui/mail_bottom_app_bar.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
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
  MessagesListBloc _messagesListBloc;
  MailBloc _mailBloc;
  ContactsBloc _contactsBloc;

  var _refreshCompleter = new Completer();
  Folder _selectedFolder;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initBlocs();
  }

  @override
  void didUpdateWidget(MessagesListAndroid oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initBlocs();
  }

  @override
  void dispose() {
    super.dispose();
    BackgroundHelper.removeOnEndAlarmObserver(onEndAlarm);
    _messagesListBloc.close();
  }

  void _initBlocs() {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    _mailBloc = BlocProvider.of<MailBloc>(context);
    _contactsBloc = BlocProvider.of<ContactsBloc>(context);

    _messagesListBloc = new MessagesListBloc(
      user: authBloc.currentUser,
      account: authBloc.currentAccount,
    );
    _mailBloc = new MailBloc(
      user: authBloc.currentUser,
      account: authBloc.currentAccount,
    );

    _contactsBloc.add(GetContacts());
    _mailBloc.add(FetchFolders());
  }

  void _showError(BuildContext ctx, String err) {
    showSnack(context: ctx, scaffoldState: Scaffold.of(ctx), msg: err);
  }

  void _initUpdateTimer() async {
    BackgroundHelper.addOnEndAlarmObserver(true, onEndAlarm);
  }

  void onEndAlarm(bool hasUpdate) {
    _mailBloc.add(RefreshMessages());
    _contactsBloc.add(GetContacts());
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
          mailBloc: _mailBloc,
          contactsBloc: _contactsBloc,
          composeAction: OpenFromDrafts(item, item.uid),
        ),
      );
    } else {
      Navigator.pushNamed(
        context,
        MessageViewRoute.name,
        arguments: MessageViewScreenArgs(
          messages: allMessages,
          initialPage: i,
          mailBloc: _mailBloc,
          messagesListBloc: _messagesListBloc,
          contactsBloc: _contactsBloc,
        ),
      );
    }
  }

  void _deleteMessage(Message message) {
    _messagesListBloc.add(
        DeleteMessages(uids: [message.uid], folderRawName: message.folder));
  }

  void _dispatchPostFoldersLoadedAction(FoldersLoaded state) {
    switch (state.postAction) {
      case PostFolderLoadedAction.subscribeToMessages:
        _messagesListBloc.add(SubscribeToMessages(
          state.selectedFolder,
          state.isStarredFilterEnabled,
          "",
        ));
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
    final authKey =
        BlocProvider.of<AuthBloc>(context).currentAccount.localId.toString();
    return MultiBlocProvider(
      key: Key(authKey),
      providers: [
        BlocProvider<MessagesListBloc>.value(value: _messagesListBloc),
        BlocProvider<MailBloc>.value(value: _mailBloc),
        BlocProvider<ContactsBloc>.value(value: _contactsBloc),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        condition: (prev, next) {
          return next is InitializedUserAndAccounts;
        },
        listener: (BuildContext context, AuthState state) {
          _initBlocs();
          setState(() {});
        },
        child: Scaffold(
          appBar: MailAppBar(),
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
                  if (state is MessagesDeleted)
                    _mailBloc.add(RefreshMessages());
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
                  if (prev is SettingsLoaded &&
                      next is SettingsLoaded &&
                      prev.darkThemeEnabled != next.darkThemeEnabled) {
                    return false;
                  } else {
                    return true;
                  }
                },
                listener: (BuildContext context, state) {
                  if (state is SettingsLoaded) {
                    if (state.syncFrequency != null) {
                      _initUpdateTimer();
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
              color: Colors.black,
              child: BlocBuilder<MessagesListBloc, MessagesListState>(
                  bloc: _messagesListBloc,
                  condition: (prevState, state) =>
                      state is SubscribedToMessages,
                  builder: (context, state) {
                    Widget child;
                    if (state is SubscribedToMessages) {
                      child = _buildMessagesStream(
                        state.messagesSub,
                        state.isStarredFilterEnabled,
                        state.searchTerm.isNotEmpty,
                      );
                    } else {
                      child = _buildMessagesLoading();
                    }
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: child,
                    );
                  }),
            ),
          ),
          bottomNavigationBar: MailBottomAppBar(selectedRoute: MailBottomAppBarRoutes.mail),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: AMFloatingActionButton(
            child: Icon(MdiIcons.pen),
            onPressed: () => Navigator.pushNamed(context, ComposeRoute.name,
                arguments: ComposeScreenArgs(
                  mailBloc: _mailBloc,
                  contactsBloc: _contactsBloc,
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildMessagesLoading() => Center(child: CircularProgressIndicator());
//  Widget _buildMessagesLoading() => SkeletonLoader();

  Widget _buildMessagesStream(Stream<List<Message>> messagesSub, bool isStarred,
      bool isSearch) {
    return StreamBuilder(
      stream: messagesSub,
      builder: (ctx, AsyncSnapshot<List<Message>> snap) {
        if (snap.connectionState == ConnectionState.active) {
          if (snap.hasError) {
            _showError(ctx, snap.error.toString());
            return ListView();
          } else if (snap.hasData && snap.data.isNotEmpty) {
            // isStarred and isSearch show FLAT structure
            List<Message> messages = snap.data;
            List<Message> threads = [];

            if (!isStarred && !isSearch) {
              messages = snap.data.where((m) => m.parentUid == null).toList();
              threads = snap.data.where((m) => m.parentUid != null).toList();
            }
            return ListView.builder(
              key: Key("mail"),
              padding: EdgeInsets.only(top: 6.0, bottom: 82.0),
              itemCount: messages.length,
              itemBuilder: (_, i) {
                final item = messages[i];
                return Column(
                  children: <Widget>[
                    MessageItem(
                      item,
                      threads.where((t) => t.parentUid == item.uid).toList(),
                      key: Key(item.localId.toString()),
                      onItemSelected: (Message item) => _onMessageSelected(snap.data, item),
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
            );
          } else {
            // build list view to be able to swipe to refresh
            if (_selectedFolder != null && _selectedFolder.needsInfoUpdate) {
              return _buildMessagesLoading();
            }

            return AMEmptyList(message: i18n(context, "messages_empty"));
          }
        } else {
          return _buildMessagesLoading();
        }
      },
    );
  }
}
