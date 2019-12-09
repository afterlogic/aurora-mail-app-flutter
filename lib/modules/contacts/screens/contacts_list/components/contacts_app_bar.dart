import 'package:aurora_mail/generated/i18n.dart';
import 'package:flutter/material.dart';

enum ContactsListAppBarAction { logout, settings, mail }

class ContactsAppBar extends StatelessWidget {
  final Function(ContactsListAppBarAction) onActionSelected;

  const ContactsAppBar({Key key, this.onActionSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(S.of(context).contacts),
      actions: <Widget>[
        PopupMenuButton(
          onSelected: onActionSelected,
          itemBuilder: (_) {
            return [
              PopupMenuItem(
                value: ContactsListAppBarAction.mail,
                child: Text(S.of(context).contacts_list_app_bar_mail),
              ),
              PopupMenuItem(
                value: ContactsListAppBarAction.settings,
                child: Text(S.of(context).messages_list_app_bar_settings),
              ),
              PopupMenuItem(
                value: ContactsListAppBarAction.logout,
                child: Text(S.of(context).messages_list_app_bar_logout),
              ),
            ];
          },
        )
      ],
    );
  }
}
