import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
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
    if (event is MoveMessages) yield* _moveMessages(event);
  }

  Stream<MessagesListState> _subscribeToMessages(
      SubscribeToMessages event) async* {
    searchTerm = event.searchTerm ?? "";
    searchPattern = event.pattern ?? SearchPattern.Default;
    try {
      final type = Folder.getFolderTypeFromNumber(event.currentFolder.type);
      final isSent = type == FolderType.sent || type == FolderType.drafts;

      final stream = (int page)=>
        _methods.getMessages(
          event.currentFolder,
          event.filter == MessagesFilter.starred,
          event.filter == MessagesFilter.unread,
          searchTerm,
          searchPattern,
          user,
          account,
          page,
        );

      yield SubscribedToMessages(
        stream,
        searchTerm,
        isSent,
        event.props.toString(),
        event.filter,
        event.currentFolder.fullNameRaw,
      );
    } catch (e, s) {
      print(e);
      print(s);
      yield SubscribedToMessages(
        null,
        searchTerm,
        false,
        event.props.toString(),
        event.filter,
        event.currentFolder.fullNameRaw,
      );
    }
  }

  Stream<MessagesListState> _deleteMessage(DeleteMessages event) async* {
    try {
      await _methods.deleteMessages(event.messages);
      yield MessagesDeleted();
    } catch (err, s) {
      yield MailError(formatError(err, s));
    }
  }

  Stream<MessagesListState> _moveMessages(MoveMessages event) async* {
    try {
      await _methods.moveMessages(event.messages,event.toFolder);
      yield MessagesMoved();
    } catch (err, s) {
      yield MailError(formatError(err, s));
    }
  }
}
