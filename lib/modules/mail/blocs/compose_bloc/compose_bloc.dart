//@dart=2.9
import 'dart:async';
import 'dart:io';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/mail/blocs/compose_bloc/compose_methods.dart';
import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/modules/mail/repository/mail_local_storage.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:flutter/foundation.dart';

import './bloc.dart';

class ComposeBloc extends Bloc<ComposeEvent, ComposeState> {
  ComposeMethods _methods;
  final User user;
  final Account account;
  final _mailLocal = new MailLocalStorage();

  ComposeBloc({@required this.user, @required this.account})
      : super(InitialComposeState()) {
    _methods = new ComposeMethods(
      user: user,
      account: account,
      pgpWorker: AppInjector.instance.pgpWorker(),
    );
  }

  @override
  Stream<ComposeState> mapEventToState(
    ComposeEvent event,
  ) async* {
    if (event is SendNote) yield* _sendNote(event);
    if (event is SendMessage) yield* _sendMessage(event);
    if (event is SendMessages) yield* _sendMessages(event);
    if (event is SaveToDrafts) yield* _saveToDrafts(event);
    if (event is UploadAttachment) yield* _addAttachment(event);
    if (event is UploadAttachments) _addAttachments(event);
    if (event is UploadEmlAttachments) yield* _uploadEmlAttachments(event);
    if (event is StartUpload) yield UploadStarted(event.tempAttachment);
    if (event is EndUpload) yield AttachmentUploaded(event.composeAttachment);
    if (event is GetComposeAttachments) yield* _getComposeAttachments(event);
    if (event is GetMessageAttachments) yield* _getForwardAttachment(event);
    if (event is GetContactsAsAttachments)
      yield* _getContactsAsAttachment(event);
    if (event is ErrorUpload)
      yield ComposeError(formatError(event.error, null));
    if (event is EncryptBody) yield* _encryptBody(event);
    if (event is DecryptEvent) yield DecryptedState();
  }

  Stream<ComposeState> _sendNote(SendNote event) async* {
    try {
      yield MessageSending(messageToShow: "Saving note");

      await _methods.sendNote(
        subject: event.subject, folderFullName: event.notesFolder.fullName, text: event.text, uid: event.messageUid
      );

      yield MessageSent(messageToShow: "Note saved");
    } catch (err, s) {
      yield ComposeError(formatError(err, s));
    }
  }

  Stream<ComposeState> _sendMessage(SendMessage event) async* {
    try {
      yield MessageSending();

      await _methods.sendMessage(
        to: event.to,
        cc: event.cc,
        bcc: event.bcc,
        isHtml: event.isHtml,
        subject: event.subject,
        composeAttachments: event.composeAttachments,
        messageText: event.messageText,
        draftUid: event.draftUid,
        sender: event.sender,
        identity: event.identity,
        alias: event.alias,
      );

      yield MessageSent();
    } catch (err, s) {
      yield ComposeError(formatError(err, s));
    }
  }

  Stream<ComposeState> _sendMessages(SendMessages events) async* {
    try {
      yield MessageSending();

      for (var event in events.messages) {
        await _methods.sendMessage(
          to: event.to,
          cc: event.cc,
          bcc: event.bcc,
          isHtml: event.isHtml,
          subject: event.subject,
          composeAttachments: event.composeAttachments,
          messageText: event.messageText,
          draftUid: event.draftUid,
          sender: event.sender,
          identity: event.identity,
          alias: event.alias,
        );
      }
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
        isHtml: event.isHtml,
        composeAttachments: event.composeAttachments,
        messageText: event.messageText,
        draftUid: event.draftUid,
        identity: event.identity,
        alias: event.alias,
      );

      yield MessageSavedInDrafts(draftUid);
    } catch (err, s) {
      yield ComposeError(formatError(err, s));
    }
  }

  Stream<ComposeState> _addAttachment(UploadAttachment event) async* {
    try {
      final files = await _mailLocal.pickFiles(type: event.type);
      for (File file in files) {
        await _uploadAttachment(file);
      }
    } catch (err, s) {
      yield ComposeError(formatError(err, s));
    }
  }

  _addAttachments(UploadAttachments event) async {
    for (var value in event.files) {
      await _uploadAttachment(value);
    }
  }

  Future _uploadAttachment(File file) {
    return _methods.uploadFile(file,
        onUploadStart: (TempAttachmentUpload tempAttachment) {
      add(StartUpload(tempAttachment));
    }, onUploadEnd: (ComposeAttachment attachment) {
      add(EndUpload(attachment));
    }, onError: (dynamic err) {
      add(ErrorUpload(ErrorToShow(err)));
    }).then((_) {
      "";
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

  Stream<ComposeState> _getForwardAttachment(
      GetMessageAttachments event) async* {
    yield ConvertingAttachments();
    try {
      final composeAttachments =
          await _methods.getMessageAttachment(event.message);

      yield ReceivedComposeAttachments(composeAttachments);
    } catch (err, s) {
      yield ComposeError(formatError(err, s));
    }
  }

  Stream<ComposeState> _getContactsAsAttachment(
      GetContactsAsAttachments event) async* {
    yield ConvertingAttachments();
    try {
      final contactsAttachments =
          await _methods.saveContactsAsTempFiles(event.contacts);

      yield ReceivedComposeAttachments(contactsAttachments);
    } catch (err, s) {
      yield ComposeError(formatError(err, s));
    }
  }

  Stream<ComposeState> _encryptBody(EncryptBody event) async* {
    try {
      if (event.encrypt && event.contacts.isEmpty) {
        yield ComposeError(
          ErrorToShow.message(S.current.error_pgp_need_contact_for_encrypt),
        );
        return;
      }
      final encrypted = await encryptBody(event);

      final type = event.encrypt ? EncryptType.Encrypt : EncryptType.Sign;
      yield EncryptComplete(encrypted, type);
    } catch (e) {
      if (e is PgpKeyNotFound) {
        yield ComposeError(ErrorToShow.message(
            S.current.error_pgp_not_found_keys_for(e.email.join(" , "))));
      } else if (e is PgpInvalidSign) {
        yield ComposeError(
            ErrorToShow.message(S.current.error_pgp_invalid_password));
      } else {
        yield ComposeError(
            ErrorToShow.message(S.current.error_server_unknown_email));
      }
    }
  }

  Future<String> encryptBody(EncryptBody event) {
    final emails = event.contacts.map((item) {
      final match = RegExp("<(.*)?>").firstMatch(item);
      if (match != null && match.groupCount > 0) {
        return match.group(1);
      } else {
        return item;
      }
    }).toList();
    return _methods.encrypt(
      event.sign,
      event.encrypt,
      event.pass,
      emails,
      event.body,
      event.senderEmail,
    );
  }

  Stream<ComposeState> _uploadEmlAttachments(
      UploadEmlAttachments event) async* {
    _methods.uploadEmlAttachments(event.message,
        onUploadStart: (TempAttachmentUpload tempAttachment) {
      add(StartUpload(tempAttachment));
    }, onUploadEnd: (ComposeAttachment attachment) {
      add(EndUpload(attachment));
    }, onError: (dynamic err) {
      add(ErrorUpload(ErrorToShow(err)));
    }).then((_) {
      "";
    });
  }

  Future<List<Contact>> getContacts(String email) {
    return _methods.getContacts(email);
  }
}
