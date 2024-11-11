//@dart=2.9
import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/message_view_methods.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:flutter/foundation.dart';

import './bloc.dart';

class MessageViewBloc extends Bloc<MessageViewEvent, MessageViewState> {
  MessageViewMethods _methods;

  MessageViewBloc({@required User user, @required Account account}) : super(InitialMessageViewState()) {
    _methods = new MessageViewMethods(
      user: user,
      account: account,
      pgpWorker: AppInjector.instance.pgpWorker(),
    );
  }

  @override
  Stream<MessageViewState> mapEventToState(
    MessageViewEvent event,
  ) async* {
    if (event is ChangeEventInviteStatus) yield* _changeEventInviteStatus(event);
    if (event is DownloadAttachment) yield* _downloadAttachment(event);
    if (event is StartDownload) yield DownloadStarted(event.fileName);
    if (event is EndDownload) yield DownloadFinished(event.path);
    if (event is CheckEncrypt) yield* _checkEncrypt(event);
    if (event is DecryptBody) yield* _decryptBody(event);
    if (event is GetFolderType) yield* _getFolderType(event);
    if (event is AddInWhiteList) yield* _addInWhiteList(event);
  }

  Stream<MessageViewState> _addInWhiteList(AddInWhiteList state) async* {
    await _methods.addInWhiteList(state.message);
  }

  Future<bool> checkInWhiteList(Message message) async {
    final has = await _methods.checkInWhiteList(message);
    return has;
  }

  Stream<MessageViewState> _downloadAttachment(
      DownloadAttachment event) async* {
    _methods.downloadAttachment(
      event.attachment,
      rect: event.rect,
      onDownloadStart: () {
//        add(StartDownload(event.attachment.fileName));
      },
      onDownloadEnd: Platform.isIOS
          ? null
          : (String path) {
//        add(EndDownload(path));
            },
    );
  }

  downloadAttachment(
      MailAttachment attachment, Function(String) onEnd, Rect rect) async {
    _methods.downloadAttachment(
      attachment,
      rect: rect,
      onDownloadStart: () {
//        add(StartDownload(event.attachment.fileName));
      },
      onDownloadEnd: (String path) {
        onEnd(path);
//        add(EndDownload(path));
      },
    );
  }

  Stream<MessageViewState> _checkEncrypt(CheckEncrypt event) async* {
    EncryptType encryptedType = _methods.checkEncrypt(event.message);
    yield MessageIsEncrypt(encryptedType);
  }

  Stream<MessageViewState> _changeEventInviteStatus(ChangeEventInviteStatus event) async* {
    try{
      final changeResult = await _methods.changeEventInviteStatus(status: event.status, calendarId: event.calendarId, fileName: event.fileName);
      yield SuccessChangedInviteStatus();
    } catch (e, st) {
      yield MessagesViewError(
        formatError(e, st)
      );
    }
  }

  Stream<MessageViewState> _decryptBody(DecryptBody event) async* {
    try {
      final decrypted = await _methods.decryptBody(
        event.type,
        event.pass,
        event.sender,
        event.body,
      );
      yield DecryptComplete(decrypted.text, decrypted.verified, event.type);
    } catch (e) {
      if (e is PgpKeyNotFound) {
        yield MessagesViewError(
          ErrorToShow.message(S.current.error_pgp_not_found_keys_for(e.email.join(" , "))),
        );
      } else if (e is PgpInvalidSign) {
        yield MessagesViewError(
            ErrorToShow.message(S.current.error_pgp_invalid_key_or_password));
      } else {
        yield MessagesViewError(ErrorToShow.message(S.current.error_pgp_can_not_decrypt));
      }
    }
  }

  Stream<MessageViewState> _getFolderType(GetFolderType event) async* {
    FolderType folderType = await _methods.getFolderType(event.folder);
    yield FolderTypeState(folderType);
  }
}
