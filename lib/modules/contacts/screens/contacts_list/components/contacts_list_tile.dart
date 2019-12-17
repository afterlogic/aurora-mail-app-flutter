import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactsListTile extends StatelessWidget {
  final Contact contact;
  final void Function(Contact) onPressed;

  ContactsListTile({@required this.contact, @required this.onPressed})
      : super(key: Key(contact.uuid));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.fullName),
      subtitle: Text(contact.viewEmail),
      onTap: () => onPressed(contact),
    );
  }
}
