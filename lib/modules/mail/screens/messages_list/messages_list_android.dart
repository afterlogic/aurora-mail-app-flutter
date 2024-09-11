//@dart=2.9
import 'dart:async';
import 'dart:io';

import 'package:aurora_mail/background/background_helper.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_actions.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_route.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/main_drawer.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/message_counter.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/selection_controller.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/stream_pagination_list.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/dialog/advanced_search.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/shared_ui/mail_bottom_app_bar.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:theme/app_theme.dart';
import 'components/mail_app_bar.dart';
import 'components/mail_folder.dart';
import 'components/message_item.dart';

class MessagesListAndroid extends StatefulWidget {
  final String initSearch;
  static int openMessageLocalId = null;
  static String openMessageId = null;
  static String openMessageFolder = null;

  const MessagesListAndroid({this.initSearch});

  @override
  _MessagesListAndroidState createState() => _MessagesListAndroidState();

  static Function(List<File> files, List<String> text) onShare;
  static List shareHolder;
}

class _MessagesListAndroidState extends BState<MessagesListAndroid>
    with WidgetsBindingObserver {
  MessagesListBloc _messagesListBloc;
  SubscribedToMessages _subscribedToMessagesState;
  MailBloc _mailBloc;
  ContactsBloc _contactsBloc;
  bool isSearch = false;
  bool isLoading = false;
  Completer _refreshCompleter;
  Folder _selectedFolder;
  bool _isBackgroundRefresh = false;
  final appBarKey = GlobalKey<MailAppBarState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    selectionController.addListener(selectionCallback);
    _initBlocs();
    MessagesListAndroid.onShare = (files, text) {
      if (files?.isNotEmpty == true || text?.isNotEmpty == true) {
        Navigator.pushNamed(
          context,
          ComposeRoute.name,
          arguments: ComposeScreenArgs(
            mailBloc: _mailBloc,
            contactsBloc: _contactsBloc,
            composeAction: InitWithAttachment(files, text),
          ),
        );
      }
    };
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MessagesListAndroid.shareHolder != null) {
        MessagesListAndroid.onShare(
            MessagesListAndroid.shareHolder[0] as List<File>,
            MessagesListAndroid.shareHolder[1] as List<String>);
        MessagesListAndroid.shareHolder = null;
      }
    });
    if (MessagesListAndroid.openMessageLocalId != null) {
      _openMessageByLocalId(MessagesListAndroid.openMessageLocalId);
      MessagesListAndroid.openMessageLocalId = null;
    } else if (MessagesListAndroid.openMessageId != null &&
        MessagesListAndroid.openMessageFolder != null) {
      _openMessageById(
        MessagesListAndroid.openMessageId,
        MessagesListAndroid.openMessageFolder,
      );
      MessagesListAndroid.openMessageId = null;
      MessagesListAndroid.openMessageFolder = null;
    }
    BackgroundHelper.addOnAlarmObserver(false, onAlarm);
    BackgroundHelper.addOnEndAlarmObserver(false, onEndAlarm);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _mailBloc.add(FetchFolders());
    }
    super.didChangeAppLifecycleState(state);
  }

  Future<void> _openMessageById(String messageId, String folder) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        final message = _mailBloc.getMessageById(messageId, folder);
        final result = await _onMessageSelectedWithProgress(message);
        if (result is ErrorToShow) {
          _showError(context, result);
        }
      } catch (e) {
        print(e);
      }
    });
  }

  Future<void> _openMessageByLocalId(int uid) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final message = await _mailBloc.getMessageByLocalId(uid);
        await _onMessageSelected(message);
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  void didUpdateWidget(MessagesListAndroid oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initBlocs();
  }

  @override
  void dispose() {
    super.dispose();
    MessagesListAndroid.onShare = null;
    WidgetsBinding.instance.removeObserver(this);
    selectionController.removeListener(selectionCallback);
    BackgroundHelper.removeOnAlarmObserver(onAlarm);
    BackgroundHelper.removeOnEndAlarmObserver(onEndAlarm);
  }

  void _initBlocs() {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (_messagesListBloc != null &&
        _messagesListBloc.account == authBloc.currentAccount) return;
    _messagesListBloc = BlocProvider.of<MessagesListBloc>(context);
    _mailBloc = BlocProvider.of<MailBloc>(context);
    _contactsBloc = BlocProvider.of<ContactsBloc>(context);
    _messagesListBloc.setUserAndAccount(
      user: authBloc.currentUser,
      account: authBloc.currentAccount,
    );
    _mailBloc.init(
      authBloc.currentUser,
      authBloc.currentAccount,
    );
    if (MessagesListAndroid.openMessageFolder != null) {
      _mailBloc.add(SelectFolderByName(MessagesListAndroid.openMessageFolder));
    }
    if (!BackgroundHelper.isBackground) {
      _mailBloc.add(FetchFolders());
    }
  }

  void _showError(BuildContext ctx, ErrorToShow err) {
    showErrorSnack(
        context: ctx, scaffoldState: scaffoldKey.currentState, msg: err);
  }

  Future<ErrorToShow> _onMessageSelectedWithProgress(Future<Message> message) {
    return Navigator.pushNamed(
      context,
      MessageProgressRoute.name,
      arguments: MessageProgressRouteArg(
        message: message,
        mailBloc: _mailBloc,
        messagesListBloc: _messagesListBloc,
        contactsBloc: _contactsBloc,
      ),
    );
  }

  Future<void> _onMessageSelected(Message _message) async {
    final message = await _mailBloc.getFullMessage(_message.localId);
    final draftsFolder = await _mailBloc.getFolderByType(FolderType.drafts);
    final isDraftMessage =
        draftsFolder != null && message.folder == draftsFolder.fullNameRaw;
    if (isDraftMessage || _selectedFolder.folderType.isNotes) {
      Navigator.pushNamed(
        context,
        ComposeRoute.name,
        arguments: ComposeScreenArgs(
          mailBloc: _mailBloc,
          contactsBloc: _contactsBloc,
          composeAction: _selectedFolder.folderType.isNotes ? OpenFromNotes(message) : OpenFromDrafts(message, message.uid),
        ),
      );
    } else {
      await Navigator.pushNamed(
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
    _messagesListBloc.add(DeleteMessages(messages: [message]));
  }

  void _unreadMessage(Message message, bool isUnread) {
    _mailBloc.add(SetSeen([message], isUnread));
  }

  void _dispatchPostFoldersLoadedAction(FoldersLoaded state) {
    switch (state.postAction) {
      case PostFolderLoadedAction.subscribeToMessages:
        _messagesListBloc.add(SubscribeToMessages(
          state.selectedFolder,
          state.filter,
          _messagesListBloc.searchParams,
          _messagesListBloc.searchText,
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

  void _onSearch(bool value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isSearch = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, next) {
        return next is InitializedUserAndAccounts;
      },
      listener: (context, state) {
        _initBlocs();
        setState(() {});
      },
      child: LayoutConfig.of(context).isTablet
          ? buildTablet(context)
          : buildPhone(context),
    );
  }

  Widget buildTablet(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: MailAppBar(
        enable: false,
        selectionController: selectionController,
      ),
      bottomNavigationBar:
          MailBottomAppBar(selectedRoute: MailBottomAppBarRoutes.mail),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: selectionController.enable ? null : AMFloatingActionButton(
        child: IconTheme(
          data: AppTheme.floatIconTheme,
          child: Icon(MdiIcons.pen),
        ),
        onPressed: () => Navigator.pushNamed(
          context,
          ComposeRoute.name,
          arguments: ComposeScreenArgs(
            mailBloc: _mailBloc,
            contactsBloc: _contactsBloc,
          ),
        ),
      ),
      body: Row(
        children: [
          ClipRRect(
            child: SizedBox(
              width: 304,
              child: Scaffold(
                body: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                      border: Border(right: BorderSide(width: 0.2))),
                  child: MainDrawer(),
                ),
              ),
            ),
          ),
          Flexible(
            child: ClipRRect(
              child: Scaffold(
                body: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: MailAppBar(
                        key: appBarKey,
                        initSearch: widget.initSearch,
                        selectionController: selectionController,
                        onSearch: _onSearch,
                        isAppBar: false,
                      ),
                    ),
                    Divider(height: 1),
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          BlocBuilder<MailBloc, MailState>(
                              bloc: _mailBloc,
                              buildWhen: (_, s) {
                                return s is FoldersLoaded;
                              },
                              builder: (context, state) {
                                if (state is FoldersLoaded) {
                                  return Positioned(
                                    right: 0,
                                    top: 0,
                                    child: MessageCounterWidget(
                                      _mailBloc.updateMessageCounter,
                                      state.selectedFolder,
                                    ),
                                  );
                                }
                                return SizedBox.shrink();
                              }),
                          MultiBlocListener(
                            listeners: [
                              BlocListener<MessagesListBloc, MessagesListState>(
                                bloc: _messagesListBloc,
                                listener: (context, state) {
                                  if (state is MailError)
                                    _showError(context, state.errorMsg);
                                  if (state is MessagesDeleted) _startRefresh();
                                  if (state is SubscribedToMessages)
                                    setState(() {
                                      _subscribedToMessagesState = state;
                                    });
                                },
                              ),
                              BlocListener<MailBloc, MailState>(
                                bloc: _mailBloc,
                                listener: (context, state) {
                                  final loading = state is FoldersLoading ||
                                      (state is FoldersLoaded &&
                                          state.isProgress == true);
                                  _setIsLoading(loading);

                                  if (state is FoldersLoaded) {
                                    setState(() =>
                                        _selectedFolder = state.selectedFolder);
                                    if (state.postAction != null) {
                                      _dispatchPostFoldersLoadedAction(state);
                                    }
                                  }
                                },
                              ),
                            ],
                            child: RefreshIndicator(
                              key: _refreshKey,
                              onRefresh: () {
                                _startRefresh();
                                if (_isBackgroundRefresh) {
                                  _isBackgroundRefresh = false;
                                } else {
                                  _mailBloc
                                      .add(RefreshMessages(_refreshCompleter));
                                  _mailBloc.add(RefreshFolders());
                                }
                                return _refreshCompleter.future;
                              },
                              backgroundColor: Colors.white,
                              color: Colors.black,
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                child: _subscribedToMessagesState != null &&
                                        !isLoading
                                    ? _buildMessagesStream(
                                        _subscribedToMessagesState.stream,
                                        _subscribedToMessagesState.filter,
                                        _subscribedToMessagesState.isSent,
                                        _subscribedToMessagesState.key,
                                        _subscribedToMessagesState.folder,
                                      )
                                    : _buildMessagesLoading(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPhone(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: MailAppBar(
        key: appBarKey,
        initSearch: widget.initSearch,
        selectionController: selectionController,
        onSearch: _onSearch,
      ),
      drawer: MainDrawer(),
      body: Stack(
        children: <Widget>[
          BlocBuilder<MailBloc, MailState>(
              bloc: _mailBloc,
              buildWhen: (_, s) {
                return s is FoldersLoaded;
              },
              builder: (context, state) {
                if (state is FoldersLoaded) {
                  return Positioned(
                    right: 0,
                    top: 0,
                    child: MessageCounterWidget(
                      _mailBloc.updateMessageCounter,
                      state.selectedFolder,
                    ),
                  );
                }
                return SizedBox.shrink();
              }),
          MultiBlocListener(
            listeners: [
              BlocListener<MessagesListBloc, MessagesListState>(
                bloc: _messagesListBloc,
                listener: (context, state) {
                  if (state is MailError) _showError(context, state.errorMsg);
                  if (state is MessagesDeleted) _startRefresh();
                  if (state is SubscribedToMessages)
                    setState(() {
                      _subscribedToMessagesState = state;
                    });
                },
              ),
              BlocListener<MailBloc, MailState>(
                bloc: _mailBloc,
                listener: (context, state) {
                  final loading = state is FoldersLoading ||
                      (state is FoldersLoaded && state.isProgress == true);
                  _setIsLoading(loading);

                  if (state is FoldersLoaded) {
                    setState(() => _selectedFolder = state.selectedFolder);
                    if (state.postAction != null) {
                      _dispatchPostFoldersLoadedAction(state);
                    }
                  }
                },
              ),
            ],
            child: RefreshIndicator(
              key: _refreshKey,
              onRefresh: () {
                if (_isBackgroundRefresh) {
                  _isBackgroundRefresh = false;
                } else {
                  _startRefresh();
                  _mailBloc.add(RefreshMessages(_refreshCompleter));
                  _mailBloc.add(RefreshFolders());
                }
                return _refreshCompleter.future;
              },
              backgroundColor: Colors.white,
              color: Colors.black,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _subscribedToMessagesState != null && !isLoading
                    ? _buildMessagesStream(
                        _subscribedToMessagesState.stream,
                        _subscribedToMessagesState.filter,
                        _subscribedToMessagesState.isSent,
                        _subscribedToMessagesState.key,
                        _subscribedToMessagesState.folder,
                      )
                    : _buildMessagesLoading(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          MailBottomAppBar(selectedRoute: MailBottomAppBarRoutes.mail),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: selectionController.enable ? null : AMFloatingActionButton(
        child: IconTheme(
          data: AppTheme.floatIconTheme,
          child: Icon(MdiIcons.pen),
        ),
        onPressed: () => Navigator.pushNamed(
          context,
          ComposeRoute.name,
          arguments: ComposeScreenArgs(
            mailBloc: _mailBloc,
            contactsBloc: _contactsBloc,
          ),
        ),
      ),
    );
  }

  Widget _buildMessagesLoading() => Center(child: CircularProgressIndicator());

  final selectionController = SelectionController<int, Message>();

  void selectionCallback() {
    //rebuild only if selection mode changes
    if(selectionController.selected.length < 2);
    setState(() { });
  }

  Widget _buildMessagesStream(
    Stream<List<Message>> Function(int page) stream,
    MessagesFilter filter,
    bool isSent,
    String key,
    String folder,
  ) {
    return Column(
      children: <Widget>[
        if (isSearch)
          TextButton(
            onPressed: () async {
              final result = await dialog(
                context: context,
                builder: (_) =>
                    AdvancedSearch(appBarKey.currentState.searchText),
              );
              if (result is String && result.isNotEmpty) {
                appBarKey.currentState.search(result);
              }
            },
            child: Text(S.of(context).btn_message_advanced_search),
          ),
        if (filter == MessagesFilter.unread)
          Column(
            children: <Widget>[
              SizedBox(height: 12.0),
              Text(S.of(context).messages_filter_unread),
              TextButton(
                child: Text(
                  S.of(context).btn_show_all,
                  style: TextStyle(color: theme.primaryColor),
                ),
                onPressed: () => _showAllMessages(context),
              )
            ],
          ),
        Flexible(
          child: StreamPaginationList(
            key: Key(key),
            folder: folder,
            selectionController: selectionController,
            header: ([FolderType.spam, FolderType.trash]
                        .contains(_selectedFolder.folderType) &&
                    !isSearch)
                ? _emptyFolder
                : null,
            builder: (context, item, threads) {
              return MessageItem(
                isSent,
                item,
                threads.where((t) => t.parentUid == item.uid).toList(),
                selectionController: selectionController,
                key: Key(item.localId.toString()),
                onItemSelected: (Message item) => _onMessageSelected(item),
                onStarMessage: _setStarred,
                onDeleteMessage: _deleteMessage,
                onUnreadMessage: _unreadMessage,
                isNote: _selectedFolder.folderType.isNotes,
              );
            },
            progressWidget: Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            ),
            onError: (context, e) {
              _showError(context, ErrorToShow(e));
              return SizedBox.shrink();
            },
            emptyWidget: (context) {
              if (_selectedFolder != null && _selectedFolder.needsInfoUpdate) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: _buildMessagesLoading(),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(child: Text(S.of(context).messages_empty)),
              );
            },
            fetch: stream,
          ),
        ),
      ],
    );
  }

  Widget _emptyFolder(int messageCount) {
    if (messageCount == null || messageCount == 0) {
      return SizedBox.shrink();
    }
    final emptyFolder =
        Folder.getFolderTypeFromNumber(_selectedFolder.type) == FolderType.trash
            ? S.of(context).btn_message_empty_trash_folder
            : S.of(context).btn_message_empty_spam_folder;
    return InkWell(
      onTap: messageCount == 0
          ? null
          : () async {
              final delete = await ConfirmationDialog.show(
                context,
                emptyFolder,
                S.of(context).hint_message_empty_folder(
                      FolderHelper.getTitle(context, _selectedFolder),
                    ),
                S.of(context).btn_delete,
                destructibleAction: true,
              );
              if (delete == true) {
                _messagesListBloc.add(EmptyFolder(_selectedFolder.fullNameRaw));
                selectionController.enable = false;
              }
            },
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_forever,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              emptyFolder,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  void _startRefresh() {
    if (_refreshCompleter?.isCompleted == false) _refreshCompleter?.complete();
    _refreshCompleter = Completer();
    _refreshKey.currentState.show();
  }

  void onAlarm() {
    _isBackgroundRefresh = true;
    _startRefresh();
  }

  void onEndAlarm(bool hasUpdate) {
    if (_refreshCompleter?.isCompleted == false) {
      _refreshCompleter?.complete();
    }
  }

  void _setIsLoading(bool value) {
    if (value != isLoading) {
      setState(() {
        isLoading = value;
      });
    }
  }
}
