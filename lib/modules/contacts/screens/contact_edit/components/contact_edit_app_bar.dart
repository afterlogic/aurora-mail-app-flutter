import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

enum ContactEditAppBarAction { save }

class ContactEditAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(ContactEditAppBarAction) onActionSelected;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const ContactEditAppBar(this.onActionSelected);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(i18n(context, "contacts_edit")),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          tooltip: i18n(context, "contacts_edit_save"),
//          onPressed: () => onActionSelected(ContactEditAppBarAction.save),
          onPressed: null,
        ),
      ],
    );
  }
}
