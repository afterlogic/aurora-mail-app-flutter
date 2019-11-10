import 'dart:async';

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
  }

  Stream<MessagesListState> _subscribeToMessages(
      SubscribeToMessages event) async* {
    final stream = _methods.subscribeToMessages(event.currentFolder);
    yield SubscribedToMessages(stream);
  }
}
