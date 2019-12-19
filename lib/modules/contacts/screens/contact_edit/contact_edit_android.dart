import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/components/contact_edit_app_bar.dart';
import 'package:flutter/material.dart';

class ContactEditAndroid extends StatefulWidget {
  final Contact contact;

  ContactEditAndroid(this.contact);

  @override
  _ContactEditAndroidState createState() => _ContactEditAndroidState();
}

class _ContactEditAndroidState extends State<ContactEditAndroid> {

  void _onAppBarActionSelected(ContactEditAppBarAction item) {
    switch(item) {
      case ContactEditAppBarAction.save:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContactEditAppBar(_onAppBarActionSelected),
    );
  }
}
