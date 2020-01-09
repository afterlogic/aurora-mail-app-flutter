import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class ComposeEvent extends Equatable {
  const ComposeEvent();

  @override
  List<Object> get props => null;
}

class SendMessage extends ComposeEvent {
  final String to;
  final String cc;
  final String bcc;
  final String subject;
  final List<ComposeAttachment> composeAttachments;
  final String messageText;
  final int draftUid;

  SendMessage({
    @required this.to,
    @required this.cc,
    @required this.bcc,
    @required this.subject,
    @required this.composeAttachments,
    @required this.messageText,
    @required this.draftUid,
  });

  @override
  List<Object> get props =>
      [to, cc, bcc, subject, composeAttachments, messageText, draftUid];
}

class SaveToDrafts extends ComposeEvent {
  final String to;
  final String cc;
  final String bcc;
  final String subject;
  final List<ComposeAttachment> composeAttachments;
  final String messageText;
  final int draftUid;

  SaveToDrafts({
    @required this.to,
    @required this.cc,
    @required this.bcc,
    @required this.subject,
    @required this.composeAttachments,
    @required this.messageText,
    @required this.draftUid,
  });

  @override
  List<Object> get props =>
      [to, cc, bcc, subject, composeAttachments, messageText, draftUid];
}

class UploadAttachment extends ComposeEvent {}

// used inside bloc, thus is not intended to be fired from flutter widgets
class StartUpload extends ComposeEvent {
  final TempAttachmentUpload tempAttachment;

  StartUpload(this.tempAttachment);

  @override
  List<Object> get props => [tempAttachment];
}

// used inside bloc, thus is not intended to be fired from flutter widgets
class EndUpload extends ComposeEvent {
  final ComposeAttachment composeAttachment;

  EndUpload(this.composeAttachment);

  @override
  List<Object> get props => [composeAttachment];
}

// used inside bloc, thus is not intended to be fired from flutter widgets
class ErrorUpload extends ComposeEvent {
  final String error;

  ErrorUpload(this.error);

  @override
  List<Object> get props => [error];
}

class GetComposeAttachments extends ComposeEvent {
  final List<MailAttachment> attachments;

  GetComposeAttachments(this.attachments);

  @override
  List<Object> get props => [attachments];
}
