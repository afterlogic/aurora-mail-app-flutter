import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactsListTile extends StatelessWidget {
  final Contact contact;

  ContactsListTile(this.contact) : super(key: Key(contact.uuid));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.fullName),
      subtitle: Text(contact.viewEmail),
    );
  }
}
