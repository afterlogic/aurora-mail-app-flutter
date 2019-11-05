import 'dart:async';

import 'package:aurora_mail/modules/mail/blocs/compose_bloc/compose_methods.dart';
import 'package:aurora_mail/utils/error_handling.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class ComposeBloc extends Bloc<ComposeEvent, ComposeState> {
  final _composeMethods = new ComposeMethods();

  @override
  ComposeState get initialState => InitialComposeState();

  @override
  Stream<ComposeState> mapEventToState(
    ComposeEvent event,
  ) async* {
    if (event is SendMessage) yield* _sendMessage(event);
    if (event is SaveToDrafts) yield* _saveToDrafts(event);
  }

  Stream<ComposeState> _sendMessage(SendMessage event) async* {
    try {
      yield MessageSending();

      await _composeMethods.sendMessage(
        to: event.to,
        cc: event.cc,
        bcc: event.bcc,
        subject: event.subject,
        messageText: event.messageText,
        draftUid: event.draftUid,
      );

      yield MessageSent();
    } catch (err, s) {
      yield ComposeError(formatError(err, s));
    }
  }

  Stream<ComposeState> _saveToDrafts(SaveToDrafts event) async* {
    try {
      final draftUid = await _composeMethods.saveToDrafts(
        to: event.to,
        cc: event.cc,
        bcc: event.bcc,
        subject: event.subject,
        messageText: event.messageText,
        draftUid: event.draftUid,
      );

      yield MessageSavedInDrafts(draftUid);
    } catch (err, s) {
      yield ComposeError(formatError(err, s));
    }
  }
}
