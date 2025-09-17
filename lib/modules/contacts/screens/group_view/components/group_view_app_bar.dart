//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/shared_ui/app_bar_icons.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';

enum GroupViewAppBarAction { sendMessage, delete, edit }

class GroupViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(GroupViewAppBarAction) onActionSelected;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const GroupViewAppBar({Key key, this.onActionSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AMAppBar(
      shadow: BoxShadow(color: Colors.transparent),
      actions: <Widget>[
        IconButton(
          icon: AppBarIcons.editUnderline(context: context),
          tooltip: S.of(context).contacts_group_view_app_bar_edit,
          onPressed: () => onActionSelected(GroupViewAppBarAction.edit),
        ),
        IconButton(
          icon: AppBarIcons.delete(context: context),
          tooltip: S.of(context).contacts_group_view_app_bar_delete,
          onPressed: () => onActionSelected(GroupViewAppBarAction.delete),
        ),
      ],
    );
  }
}
