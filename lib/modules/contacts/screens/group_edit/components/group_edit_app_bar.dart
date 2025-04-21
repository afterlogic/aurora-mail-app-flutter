//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
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
      title: Text(isEdit
          ? S.of(context).contacts_group_edit
          : S.of(context).contacts_group_add),
      backgroundColor: Color(0xFFF4F1FD),
      textStyle:TextStyle(color: Color(0xFF2D2D2D), fontSize: 18, fontWeight: FontWeight.w600),
      shadow: BoxShadow(color: Colors.transparent),
      actions: <Widget>[
        Builder(
          builder: (context) => TextButton(
            child: Text(
              S.of(context).btn_save,
              style: TextStyle(
                  color: Theme.of(context)?.appBarTheme?.iconTheme?.color),
            ),
            onPressed: () =>
                onActionSelected(context, GroupEditAppBarAction.save),
          ),
        ),
      ],
    );
  }
}
