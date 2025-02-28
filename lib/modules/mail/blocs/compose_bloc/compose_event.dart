//@dart=2.9
import 'dart:io';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';

abstract class ComposeEvent extends Equatable {
  const ComposeEvent();

  @override
  List<Object> get props => null;
}

class SendMessages extends ComposeEvent with AlwaysNonEqualObject {
  final List<SendMessage> messages;

  SendMessages(this.messages);
}

class SendNote extends ComposeEvent with AlwaysNonEqualObject {
  final String subject;
  final String text;
  final Folder notesFolder;
  final String messageUid;

  const SendNote({
    @required this.notesFolder,
    @required this.subject,
    @required this.text,
    this.messageUid
  });

  @override
  List<Object> get props =>
      [subject, text, notesFolder, messageUid];
}

class SendMessage extends ComposeEvent with AlwaysNonEqualObject {
  final String to;
  final String cc;
  final String bcc;
  final String subject;
  final bool isHtml;
  final List<ComposeAttachment> composeAttachments;
  final String messageText;
  final int draftUid;
  final Account sender;
  final AccountIdentity identity;
  final Aliases alias;

  SendMessage({
    @required this.isHtml,
    @required this.to,
    @required this.cc,
    @required this.bcc,
    @required this.subject,
    @required this.composeAttachments,
    @required this.messageText,
    @required this.draftUid,
    this.sender,
    this.identity,
    this.alias,
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
  final bool isHtml;
  final AccountIdentity identity;

  final Aliases alias;

  SaveToDrafts({
    @required this.to,
    @required this.cc,
    @required this.bcc,
    @required this.subject,
    @required this.composeAttachments,
    @required this.messageText,
    @required this.draftUid,
    @required this.isHtml,
    this.identity,
    this.alias,
  });

  @override
  List<Object> get props =>
      [to, cc, bcc, subject, composeAttachments, messageText, draftUid];
}

class UploadAttachment extends ComposeEvent with AlwaysNonEqualObject {
  final FileType type;

  UploadAttachment(this.type);
}

class UploadAttachments extends ComposeEvent with AlwaysNonEqualObject {
  final List<File> files;

  UploadAttachments(this.files);
}

class UploadEmlAttachments extends ComposeEvent with AlwaysNonEqualObject {
  final Message message;

  UploadEmlAttachments(this.message);
}

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
  final ErrorToShow error;

  ErrorUpload(this.error);

  @override
  List<Object> get props => [error];
}

class GetMessageAttachments extends ComposeEvent {
  final Message message;

  GetMessageAttachments(this.message);

  @override
  List<Object> get props => [message];
}

class GetComposeAttachments extends ComposeEvent {
  final List<MailAttachment> attachments;

  GetComposeAttachments(this.attachments);

  @override
  List<Object> get props => [attachments];
}

class GetContactsAsAttachments extends ComposeEvent {
  final List<Contact> contacts;

  GetContactsAsAttachments(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class EncryptBody extends ComposeEvent with AlwaysNonEqualObject {
  final bool encrypt;
  final bool sign;
  final String pass;
  final Set<String> contacts;
  final String body;
  final String senderEmail;

  EncryptBody(this.contacts, this.body, this.encrypt, this.sign, this.pass,
      this.senderEmail);

  @override
  List<Object> get props => [];
}

class DecryptEvent extends ComposeEvent {
  @override
  List<Object> get props => [];
}
