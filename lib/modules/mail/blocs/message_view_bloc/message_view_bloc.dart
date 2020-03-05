import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/message_view_methods.dart';
import 'package:aurora_mail/utils/permissions.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:flutter/foundation.dart';

import './bloc.dart';

class MessageViewBloc extends Bloc<MessageViewEvent, MessageViewState> {
  MessageViewMethods _methods;

  MessageViewBloc({@required User user, @required Account account}) {
    _methods = new MessageViewMethods(
      user: user,
      account: account,
      pgpWorker: AppInjector.instance.pgpWorker(),
    );
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
    if (event is CheckEncrypt) yield* _checkEncrypt(event);
    if (event is DecryptBody) yield* _decryptBody(event);
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

  Stream<MessageViewState> _checkEncrypt(CheckEncrypt event) async* {
    EncryptType encryptedType = _methods.checkEncrypt(event.message);
    yield MessageIsEncrypt(encryptedType);
  }

  Stream<MessageViewState> _decryptBody(DecryptBody event) async* {
    try {
      final decrypted = await _methods.decryptBody(
        event.type,
        event.pass,
        event.sender,
        event.body,
      );
      yield DecryptComplete(decrypted.text, decrypted.verified);
    } catch (e) {
      if (e is PgpKeyNotFound) {
        yield MessagesViewError(
          "not_found_keys_for",
          {"users": e.email.join(" , ")},
        );
      } else if (e is PgpInvalidSign) {
        yield MessagesViewError("invalid_key_or_password");
      } else {
        yield MessagesViewError("can_not_decrypt");
      }
    }
  }
}
