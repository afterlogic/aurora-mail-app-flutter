import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';

enum GroupEditAppBarAction { save }

class GroupEditAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(BuildContext, GroupEditAppBarAction) onActionSelected;
  final bool isEdit;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const GroupEditAppBar(this.onActionSelected, this.isEdit);

  @override
  Widget build(BuildContext context) {
    return AMAppBar(
      title: Text(
          i18n(context, isEdit ? "contacts_group_edit" : "contacts_group_add")),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, "contacts_edit_save")),
          onPressed: () =>
              onActionSelected(context, GroupEditAppBarAction.save),
        ),
      ],
    );
  }
}
