import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class ContactEditAndroid extends StatefulWidget {
  final Contact contact;

  ContactEditAndroid(this.contact);

  @override
  _ContactEditAndroidState createState() => _ContactEditAndroidState();
}

class _ContactEditAndroidState extends State<ContactEditAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n(context, "contacts_edit")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            tooltip: i18n(context, "contacts_view_app_bar_attach"),
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
