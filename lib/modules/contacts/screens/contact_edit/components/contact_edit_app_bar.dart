//@dart=2.9
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/internationalization.dart';
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
      title: Text(i18n(context, isEdit ? S.contacts_edit : S.contacts_add)),
      actions: <Widget>[
        Builder(
          builder: (context) => TextButton(
            child: Text(
              i18n(context, S.btn_save),
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
