import 'dart:async';

import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/message_view_methods.dart';
import 'package:aurora_mail/utils/permissions.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class MessageViewBloc extends Bloc<MessageViewEvent, MessageViewState> {
  final _methods = new MessageViewMethods();

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

  Stream<MessageViewState> _downloadAttachment(
      DownloadAttachment event) async* {
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
