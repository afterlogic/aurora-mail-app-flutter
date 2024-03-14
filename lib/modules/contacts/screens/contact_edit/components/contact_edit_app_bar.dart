//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';

enum ContactEditAppBarAction { save }

class ContactEditAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isEdit;
  final Function(BuildContext, ContactEditAppBarAction) onActionSelected;

  const ContactEditAppBar(this.onActionSelected, {@required this.isEdit});

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AMAppBar(
      title: Text(isEdit ? S.of(context).contacts_edit : S.of(context).contacts_add),
      actions: <Widget>[
        Builder(
          builder: (context) => TextButton(
            child: Text(
              S.of(context).btn_save,
              style: TextStyle(
                  color: Theme.of(context)?.appBarTheme?.iconTheme?.color),
            ),
            onPressed: () =>
                onActionSelected(context, ContactEditAppBarAction.save),
          ),
        ),
      ],
    );
  }
}
