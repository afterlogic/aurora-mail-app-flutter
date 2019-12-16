import 'package:aurora_mail/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum ContactViewAppBarAction { attach, sendMessage, searchMessages, edit }

class ContactViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(ContactViewAppBarAction) onActionSelected;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const ContactViewAppBar({Key key, this.onActionSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.attach_file),
          tooltip: S.of(context).contacts_view_app_bar_attach,
//          onPressed: () => onActionSelected(ContactViewAppBarAction.attach),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(Icons.mail_outline),
          tooltip: S.of(context).contacts_view_app_bar_send_message,
//          onPressed: () => onActionSelected(ContactViewAppBarAction.sendMessage),
        onPressed: null,
        ),
        IconButton(
          icon: Icon(MdiIcons.emailSearchOutline),
          tooltip: S.of(context).contacts_view_app_bar_search_messages,
//          onPressed: () => onActionSelected(ContactViewAppBarAction.searchMessages),
        onPressed: null,
        ),
        IconButton(
          icon: Icon(Icons.edit),
          tooltip: S.of(context).contacts_view_app_bar_edit_contact,
//          onPressed: () => onActionSelected(ContactViewAppBarAction.edit),
        onPressed: null,
        ),
      ],
    );
  }
}
