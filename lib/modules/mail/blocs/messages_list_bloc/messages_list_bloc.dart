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
      final fetch = (int offset) => _methods.getMessages(
            event.currentFolder,
            event.isStarred,
            searchTerm,
            searchPattern,
            user,
            account,
            offset,
          );
      yield SubscribedToMessages(fetch, event.isStarred, searchTerm);
    } catch (e, s) {
      print(e);
      print(s);
      yield SubscribedToMessages(null, event.isStarred, searchTerm);
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
