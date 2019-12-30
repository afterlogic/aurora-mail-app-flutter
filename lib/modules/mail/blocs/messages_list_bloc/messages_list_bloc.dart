import 'dart:async';

import 'package:aurora_mail/utils/api_utils.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';
import 'messages_list_methods.dart';

class MessagesListBloc extends Bloc<MessagesListEvent, MessagesListState> {
  final _methods = new MessagesListMethods();

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
    final stream =
        _methods.subscribeToMessages(event.currentFolder, event.isStarred);
    yield SubscribedToMessages(stream, event.isStarred);
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
