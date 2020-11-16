import 'dart:io';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';

//enum ComposeType { none, fromDrafts, reply, replyAll, forward, emailToContacts }

abstract class ComposeAction {}

class OpenFromDrafts implements ComposeAction {
  final int draftUid;
  final Message message;

  const OpenFromDrafts(this.message, this.draftUid);
}

class Forward implements ComposeAction {
  final Message message;

  final bool showImage;

  const Forward(this.message, this.showImage);
}

class Resend implements ComposeAction {
  final Message message;

  final bool showImage;

  const Resend(this.message, this.showImage);
}
class ForwardAsAttachment implements ComposeAction {
  final Message message;

  const ForwardAsAttachment(this.message);
}

class Reply implements ComposeAction {
  final Message message;

  final bool showImage;

  const Reply(this.message, this.showImage);
}

class ReplyToAll implements ComposeAction {
  final Message message;

  final bool showImage;

  const ReplyToAll(this.message, this.showImage);
}

class EmailToContacts implements ComposeAction {
  final List<String> emails;

  const EmailToContacts(this.emails);
}

class SendContacts implements ComposeAction {
  final List<Contact> contacts;

  const SendContacts(this.contacts);
}

class InitWithAttachment implements ComposeAction {
  final List<File> files;
  final List<String> message;

  const InitWithAttachment(this.files, this.message);
}
