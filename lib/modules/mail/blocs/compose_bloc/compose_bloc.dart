import 'dart:async';

import 'package:aurora_mail/modules/mail/blocs/compose_bloc/compose_methods.dart';
import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/utils/error_handling.dart';
import 'package:aurora_mail/utils/permissions.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class ComposeBloc extends Bloc<ComposeEvent, ComposeState> {
  final _methods = new ComposeMethods();

  @override
  ComposeState get initialState => InitialComposeState();

  @override
  Stream<ComposeState> mapEventToState(
    ComposeEvent event,
  ) async* {
    if (event is SendMessage) yield* _sendMessage(event);
    if (event is SaveToDrafts) yield* _saveToDrafts(event);
    if (event is UploadAttachment) yield* _uploadAttachment(event);
    if (event is StartUpload) yield UploadStarted(event.tempAttachment);
    if (event is EndUpload) yield AttachmentUploaded(event.composeAttachment);
    if (event is GetComposeAttachments) yield* _getComposeAttachments(event);
    if (event is ErrorUpload)
      yield ComposeError(formatError(event.error, null));
  }

  Stream<ComposeState> _sendMessage(SendMessage event) async* {
    try {
      yield MessageSending();

      await _methods.sendMessage(
        to: event.to,
        cc: event.cc,
        bcc: event.bcc,
        subject: event.subject,
        composeAttachments: event.composeAttachments,
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
      final draftUid = await _methods.saveToDrafts(
        to: event.to,
        cc: event.cc,
        bcc: event.bcc,
        subject: event.subject,
        composeAttachments: event.composeAttachments,
        messageText: event.messageText,
        draftUid: event.draftUid,
      );

      yield MessageSavedInDrafts(draftUid);
    } catch (err, s) {
      yield ComposeError(formatError(err, s));
    }
  }

  Stream<ComposeState> _uploadAttachment(UploadAttachment event) async* {
    try {
      await getStoragePermissions();
    } catch (err) {
      yield ComposeError(err);
    }

    _methods.uploadFile(onUploadStart: (TempAttachmentUpload tempAttachment) {
      add(StartUpload(tempAttachment));
    }, onUploadEnd: (ComposeAttachment attachment) {
      add(EndUpload(attachment));
    }, onError: (dynamic err) {
      add(ErrorUpload(err));
    });
  }

  Stream<ComposeState> _getComposeAttachments(
      GetComposeAttachments event) async* {
    yield ConvertingAttachments();
    try {
      final composeAttachments =
          await _methods.getComposeAttachments(event.attachments);

      yield ReceivedComposeAttachments(composeAttachments);
    } catch (err, s) {
      yield ComposeError(formatError(err, s));
    }
  }
}
