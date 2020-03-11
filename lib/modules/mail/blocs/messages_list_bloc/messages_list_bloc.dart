import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'bloc.dart';
import 'messages_list_methods.dart';

class MessagesListBloc extends Bloc<MessagesListEvent, MessagesListState> {
  final User user;
  final Account account;
  MessagesListMethods _methods;

  String searchTerm = "";
  SearchPattern searchPattern = SearchPattern.Default;

  MessagesListBloc({@required this.user, @required this.account}) {
    _methods = new MessagesListMethods(user: user, account: account);
  }

  @override
  MessagesListState get initialState => MessagesEmpty();

  @override
  Stream<MessagesListState> mapEventToState(
    MessagesListEvent event,
  ) async* {

    if (event is SubscribeToMessages) yield* _subscribeToMessages(event);
    if (event is StopMessagesRefresh) yield MessagesRefreshed();
    if (event is DeleteMessages) yield* _deleteMessage(event);
  }

  Stream<MessagesListState> _subscribeToMessages(
      SubscribeToMessages event) async* {
    searchTerm = event.searchTerm ?? "";
    searchPattern = event.pattern ?? SearchPattern.Default;
    try {
      final type = Folder.getFolderTypeFromNumber(event.currentFolder.type);
      final isSent = type == FolderType.sent || type == FolderType.drafts;

      final fetch = (int offset) => _methods.getMessages(
            event.currentFolder,
            event.isStarred,
            searchTerm,
            searchPattern,
            user,
            account,
            offset,
          );
//_methods.subscribeToMessages(
//        folder: event.currentFolder,
//        isStarred: event.filter == MessagesFilter.starred,
//        isUnread: event.filter == MessagesFilter.unread,
//        searchTerm: searchTerm,
//        searchPattern: searchPattern,
//        user: user,
//        account: account,
//      );
      yield SubscribedToMessages(
        fetch,
        event.isStarred,
        searchTerm,
        isSent,
        event.props.toString(),
      );
    } catch (e, s) {
      print(e);
      print(s);
      yield SubscribedToMessages(
        null,
        event.isStarred,
        searchTerm,
        false,
        event.props.toString(),
      );
    }
  }

  Stream<MessagesListState> _deleteMessage(DeleteMessages event) async* {
    try {
      await _methods.deleteMessages(event.uids, event.folderRawName);
      yield MessagesDeleted();
    } catch (err, s) {
      yield MailError(formatError(err, s));
    }
  }
}
