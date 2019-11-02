import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ComposeBloc extends Bloc<ComposeEvent, ComposeState> {
  @override
  ComposeState get initialState => InitialComposeState();

  @override
  Stream<ComposeState> mapEventToState(
    ComposeEvent event,
  ) async* {
    if (event is SendMessage) yield* _sendMessage(event);
    if (event is SaveToDrafts) yield* _saveToDrafts(event);
  }

  Stream<ComposeState> _sendMessage(SendMessage event) {

  }

  Stream<ComposeState> _saveToDrafts(SaveToDrafts event) {

  }
}
