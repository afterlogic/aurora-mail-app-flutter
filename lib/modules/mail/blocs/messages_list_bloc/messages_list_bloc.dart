//@dart=2.9
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
  User _user;
  Account _account;
  MessagesListMethods _methods;

  List<SearchParams> searchParams = [];

  String searchText = '';

  MessagesListBloc({@required User user, @required Account account}) : super(MessagesEmpty()) {
    setUserAndAccount(user: user, account: account);
  }

  Account get account => _account;

  void setUserAndAccount({@required User user, @required Account account}) {
    _user = user;
    _account = account;
    _methods = new MessagesListMethods(user: _user, account: _account);
  }

  @override
  Stream<MessagesListState> mapEventToState(
    MessagesListEvent event,
  ) async* {
    if (event is SubscribeToMessages) yield* _subscribeToMessages(event);
    if (event is StopMessagesRefresh) yield MessagesRefreshed();
    if (event is DeleteMessages) yield* _deleteMessage(event);
    if (event is MoveMessages) yield* _moveMessages(event);
    if (event is MoveToFolderMessages) yield* _moveToFolder(event);
    if (event is EmptyFolder) yield* _emptyFolder(event);
  }

  Stream<MessagesListState> _subscribeToMessages(
      SubscribeToMessages event) async* {
    searchParams = event.searchParams ?? [];
    searchText = event.searchText ?? '';
    try {
      final type = Folder.getFolderTypeFromNumber(event.currentFolder.type);
      final isSent = type == FolderType.sent || type == FolderType.drafts;

      final stream = (int page) => _methods.getMessages(
            event.currentFolder,
            event.filter == MessagesFilter.starred,
            event.filter == MessagesFilter.unread,
            searchParams,
            _user,
            _account,
            page,
          );

      yield SubscribedToMessages(
        stream,
        searchParams,
        isSent,
        event.props.toString() + event.currentFolder.fullNameHash,
        event.filter,
        event.currentFolder.fullNameRaw,
      );
    } catch (e, s) {
      print(e);
      print(s);
      yield SubscribedToMessages(
        null,
        searchParams,
        false,
        event.props.toString() + event.currentFolder.fullNameHash,
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
      await _methods.moveMessages(event.messages, event.toFolder);
      yield MessagesMoved();
    } catch (err, s) {
      yield MailError(formatError(err, s));
    }
  }

  Stream<MessagesListState> _moveToFolder(MoveToFolderMessages event) async* {
    try {
      await _methods.moveToFolder(event.messages, event.folder);
      event.completer?.complete();
      yield MessagesMoved();
    } catch (err, s) {
      yield MailError(formatError(err, s));
    }
  }

  Stream<MessagesListState> _emptyFolder(EmptyFolder event) async* {
    try {
      await _methods.emptyFolder(event.folder);
      yield FolderCleared();
    } catch (err, s) {
      yield MailError(formatError(err, s));
    }
  }
}
