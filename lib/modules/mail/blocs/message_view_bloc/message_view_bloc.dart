import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/message_view_methods.dart';
import 'package:aurora_mail/utils/permissions.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import './bloc.dart';

class MessageViewBloc extends Bloc<MessageViewEvent, MessageViewState> {
  MessageViewMethods _methods;

  MessageViewBloc({@required User user, @required Account account}) {
    _methods = new MessageViewMethods(user: user, account: account);
  }

  @override
  MessageViewState get initialState => InitialMessageViewState();

  @override
  Stream<MessageViewState> mapEventToState(
    MessageViewEvent event,
  ) async* {
    if (event is DownloadAttachment) yield* _downloadAttachment(event);
    if (event is StartDownload) yield DownloadStarted(event.fileName);
    if (event is EndDownload) yield DownloadFinished(event.path);
  }

  Stream<MessageViewState> _downloadAttachment(DownloadAttachment event) async* {
    try {
      await getStoragePermissions();
    } catch (err) {
      yield MessagesViewError(err.toString());
    }

    _methods.downloadAttachment(
      event.attachment,
      onDownloadStart: () {
//        add(StartDownload(event.attachment.fileName));
      },
      onDownloadEnd: (String path) {
//        add(EndDownload(path));
      },
    );
  }
}
