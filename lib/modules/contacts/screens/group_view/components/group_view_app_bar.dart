import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

enum GroupViewAppBarAction { sendMessage, delete, edit }

class GroupViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(GroupViewAppBarAction) onActionSelected;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const GroupViewAppBar({Key key, this.onActionSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.mail_outline),
          tooltip: i18n(context, "contacts_group_view_app_bar_send_message"),
//          onPressed: () => onActionSelected(ContactViewAppBarAction.sendMessage),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          tooltip: i18n(context, "contacts_group_view_app_bar_delete"),
          onPressed: () => onActionSelected(GroupViewAppBarAction.delete),
        ),
        IconButton(
          icon: Icon(Icons.edit),
          tooltip: i18n(context, "contacts_group_view_app_bar_edit"),
          onPressed: () => onActionSelected(GroupViewAppBarAction.edit),
        ),
      ],
    );
  }
}
