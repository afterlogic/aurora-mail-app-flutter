import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/settings/screens/manage_users/componenets/account_tile.dart';
import 'package:aurora_mail/modules/settings/screens/manage_users/manage_users_route.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class UserSelectionPopup extends StatelessWidget {
  final List<User> users;

  const UserSelectionPopup(this.users);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (v) {
        if (v == true) Navigator.pushNamed(context, ManageUsersRoute.name);
      },
      icon: Icon(Icons.account_circle),
      itemBuilder: (_) =>
      [
        ...users.map((user) {
          return PopupMenuItem(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                UserTile(user: user, compact: true),
                Divider(height: 0.0),
              ],
            ),
          );
        }).toList(),
        PopupMenuItem(
          enabled: false,
          height: 24.0,
          child: SizedBox(height: 24.0),
        ),
        PopupMenuItem(
          value: true,
          child: Row(
            children: <Widget>[
              Icon(Icons.account_circle, color: Theme.of(context).disabledColor),
              SizedBox(width: 12.0),
              Text(i18n(context, "settings_accounts_manage")),
            ],
          ),
        ),
      ],
    );
  }
}