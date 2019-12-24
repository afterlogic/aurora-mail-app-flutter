import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class ContactsListTile extends StatelessWidget {
  final Contact contact;
  final void Function(Contact) onPressed;
  final void Function(Contact) onDeleteContact;

  ContactsListTile(
      {@required this.contact, @required this.onPressed, @required this.onDeleteContact})
      : super(key: Key(contact.uuid));

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(contact.uuid),
      direction: DismissDirection.endToStart,
      child: ListTile(
        title: Text(contact.fullName),
        subtitle: Text(contact.viewEmail),
        onTap: () => onPressed(contact),
      ),
      onDismissed: (_) => onDeleteContact(contact),
      confirmDismiss: (_) => ConfirmationDialog.show(
          context,
          i18n(context, "contacts_delete_title"),
          i18n(context, "contacts_delete_desc_with_name", {"contact": contact.fullName}),
          i18n(context, "btn_delete")),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 16.0,
              top: 0.0,
              bottom: 0.0,
              child: Icon(Icons.delete_outline, color: Colors.white, size: 36.0),
            ),
          ],
        ),
      ),
    );
  }
}
