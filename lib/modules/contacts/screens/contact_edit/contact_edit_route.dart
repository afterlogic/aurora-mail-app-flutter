import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';

class ContactEditRoute {
  static const name = "contact_edit";
}

class ContactEditScreenArgs {
  final Contact contact;

  ContactEditScreenArgs(this.contact);
}
