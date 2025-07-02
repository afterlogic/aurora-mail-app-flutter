//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_color.dart';

enum GroupViewAppBarAction { sendMessage, delete, edit }

class GroupViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(GroupViewAppBarAction) onActionSelected;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const GroupViewAppBar({Key key, this.onActionSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AMAppBar(
      backgroundColor: AppColor.appBarBackground,
      shadow: BoxShadow(color: Colors.transparent),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          tooltip: S.of(context).contacts_group_view_app_bar_edit,
          onPressed: () => onActionSelected(GroupViewAppBarAction.edit),
        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          tooltip: S.of(context).contacts_group_view_app_bar_delete,
          onPressed: () => onActionSelected(GroupViewAppBarAction.delete),
        ),
      ],
    );
  }
}
