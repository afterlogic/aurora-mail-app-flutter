import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

enum GroupEditAppBarAction { save }

class GroupEditAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(GroupEditAppBarAction) onActionSelected;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const GroupEditAppBar(this.onActionSelected);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(i18n(context, "contacts_group_edit")),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          tooltip: i18n(context, "contacts_edit_save"),
          onPressed: () => onActionSelected(GroupEditAppBarAction.save),
        ),
      ],
    );
  }
}
