import 'dart:ui';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:equatable/equatable.dart';

abstract class MessageViewEvent extends Equatable {
  const MessageViewEvent();
}

class DownloadAttachment extends MessageViewEvent {
  final MailAttachment attachment;
  final Rect rect;
  const DownloadAttachment(this.attachment, this.rect);

  @override
  List<Object> get props => [attachment];
}

class StartDownload extends MessageViewEvent {
  final String fileName;

  const StartDownload(this.fileName);

  @override
  List<Object> get props => [fileName];
}

class EndDownload extends MessageViewEvent {
  final String path;

  const EndDownload(this.path);

  @override
  List<Object> get props => [path];
}

class CheckEncrypt extends MessageViewEvent with AlwaysNonEqualObject {
  final String message;

  CheckEncrypt(this.message);

  @override
  List<Object> get props => [message];
}

class GetFolderType extends MessageViewEvent with AlwaysNonEqualObject {
  final String folder;

  GetFolderType(this.folder);

  @override
  List<Object> get props => [folder];
}

class DecryptBody extends MessageViewEvent with AlwaysNonEqualObject {
  final EncryptType type;
  final String pass;
  final String sender;
  final String body;

  DecryptBody(this.type, this.pass, this.sender, this.body);

  @override
  List<Object> get props => [sender, body];
}

class AddInWhiteList extends MessageViewEvent {
  final Message message;

  AddInWhiteList(this.message);

  @override
  List<Object> get props => [message];
}
