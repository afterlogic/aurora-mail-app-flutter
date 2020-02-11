import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

enum ContactEditAppBarAction { save }

class ContactEditAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isEdit;
  final Function(BuildContext, ContactEditAppBarAction) onActionSelected;

  const ContactEditAppBar(this.onActionSelected, {@required this.isEdit});

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(i18n(context, isEdit ? "contacts_edit" : "contacts_add")),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          tooltip: i18n(context, "contacts_edit_save"),
          onPressed:() => onActionSelected(context, ContactEditAppBarAction.save),
        ),
      ],
    );
  }
}
