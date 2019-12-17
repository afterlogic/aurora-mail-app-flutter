import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

enum ContactEditAppBarAction { cancel, save }

class ContactEditAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(ContactEditAppBarAction) onActionSelected;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const ContactEditAppBar({Key key, this.onActionSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.close),
        tooltip: i18n(context, "contacts_edit_cancel"),
        onPressed: () => onActionSelected(ContactEditAppBarAction.cancel),
      ),
      title: Text(i18n(context, "contacts_edit")),
      actions: <Widget>[],
    );
  }
}
