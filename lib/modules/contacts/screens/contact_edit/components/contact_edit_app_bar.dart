import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';

enum ContactEditAppBarAction { save }

class ContactEditAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isEdit;
  final Function(BuildContext, ContactEditAppBarAction) onActionSelected;

  const ContactEditAppBar(this.onActionSelected, {@required this.isEdit});

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    return AMAppBar(
      title: Text(i18n(context, isEdit ? "contacts_edit" : "contacts_add")),
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
