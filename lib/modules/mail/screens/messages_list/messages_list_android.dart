import 'dart:async';

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
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'components/mail_app_bar.dart';
import 'components/message_item.dart';

class MessagesListAndroid extends StatefulWidget {
  final String initSearch;

  const MessagesListAndroid({this.initSearch});

  @override
  _MessagesListAndroidState createState() => _MessagesListAndroidState();
}

class _MessagesListAndroidState extends BState<MessagesListAndroid> {
  MessagesListBloc _messagesListBloc;
  MailBloc _mailBloc;
  ContactsBloc _contactsBloc;

  Completer _refreshCompleter;
  Folder _selectedFolder;

  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
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
    _mailBloc.init(
      authBloc.currentUser,
      authBloc.currentAccount,
    );

    _contactsBloc.add(GetContacts());
    _mailBloc.add(FetchFolders());
  }

  void _showError(BuildContext ctx, String err) {
    showSnack(context: ctx, scaffoldState: Scaffold.of(ctx), msg: err);
  }

  void _onMessageSelected(Message item) async {
    final message = await _mailBloc.getFullMessage(item);
    final draftsFolder = (_mailBloc.state as FoldersLoaded).folders.firstWhere(
        (f) => f.folderType == FolderType.drafts,
        orElse: () => null);

    if (draftsFolder != null && message.folder == draftsFolder.fullNameRaw) {
      Navigator.pushNamed(
        context,
        ComposeRoute.name,
        arguments: ComposeScreenArgs(
          mailBloc: _mailBloc,
          contactsBloc: _contactsBloc,
          composeAction: OpenFromDrafts(message, message.uid),
        ),
      );
    } else {
      Navigator.pushNamed(
        context,
        MessageViewRoute.name,
        arguments: MessageViewScreenArgs(
          message: message,
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
          state.filter,
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

  void _showAllMessages(BuildContext context) {
    _mailBloc.add(SelectFolder(_selectedFolder));
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
          appBar: MailAppBar(initSearch: widget.initSearch),
          drawer: MainDrawer(),
          body: MultiBlocListener(
            listeners: [
              BlocListener(
                bloc: _messagesListBloc,
                listener: (BuildContext context, state) {
                  if (state is MessagesRefreshed || state is MailError) {
                    _endRefresh();
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
                    if (state.isProgress == true) {
                      _startRefresh();
                    } else {
                      _endRefresh();
                    }
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
                    _mailBloc.add(RefreshMessages());
                  }
                },
              ),
            ],
            child: RefreshIndicator(
              key: _refreshKey,
              onRefresh: () {
                if (_refreshCompleter == null) {
                  _mailBloc.add(RefreshMessages(true));
                  _refreshCompleter = Completer();
                }
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
                        state.key.toString(),
                        state.fetch,
                        state.isStarredFilterEnabled,
                        state.isSent
                        state.filter,
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
          bottomNavigationBar:
              MailBottomAppBar(selectedRoute: MailBottomAppBarRoutes.mail),
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

  Widget _buildMessagesStream(
    String key,
    Future<List<Message>> Function(int offset) fetch,
    bool isStarred,
    bool isSent,
      MessagesFilter filter,
  ) {
    final loadingProgress = _selectedFolder?.needsInfoUpdate == true;
    final isSearch=filter != MessagesFilter.none;

    return
      Column(
          children: <Widget>[
      if (filter == MessagesFilter.unread)
    Column(
      children: <Widget>[
        SizedBox(height: 12.0),
        Text(i18n(context, "messages_filter_unread")),
        FlatButton(
          child: Text(i18n(context, "btn_show_all")),
          textColor: theme.accentColor,
          onPressed: () => _showAllMessages(context),
        )
      ],
    ),
    Flexible(
    child: MessageListWidget(
      key: Key(key),
      isLoading: loadingProgress,
      isSearch: isSearch,
      isStarred: isStarred,
      fetch: fetch,
      builder: (item, thread) {
        return MessageItem(
          isSent,
          item,
          thread,
          key: Key(item.localId.toString()),
          onItemSelected: (Message item) => _onMessageSelected(item),
          onStarMessage: _setStarred,
          onDeleteMessage: _deleteMessage,
        );
      },
    ),),]),]);
  }

  _startRefresh() {
    _refreshCompleter = Completer();
    _refreshKey.currentState.show();
  }

  _endRefresh() {
    _refreshCompleter?.complete();
    _refreshCompleter = null;
  }
}
