//@dart=2.9
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
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
          i18n(context, isEdit ? S.contacts_group_edit : S.contacts_group_add)),
      actions: <Widget>[
        Builder(
          builder: (context) => FlatButton(
            child: Text(
              i18n(context, S.contacts_edit_save),
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
