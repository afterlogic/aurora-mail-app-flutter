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

  const Forward(this.message);
}

class Reply implements ComposeAction {
  final Message message;

  const Reply(this.message);
}

class ReplyToAll implements ComposeAction {
  final Message message;

  const ReplyToAll(this.message);
}

class EmailToContacts implements ComposeAction {
  final List<Contact> contacts;

  const EmailToContacts(this.contacts);
}
