import 'package:aurora_mail/res/icons/webmail_icons.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

enum ContactViewAppBarAction {
  attach,
  searchMessages,
  edit,
  share,
  unshare,
  delete
}

class ContactViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool allowEdit;
  final bool allowShare;
  final bool allowUnshare;
  final bool allowDelete;
  final Function(ContactViewAppBarAction) onActionSelected;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const ContactViewAppBar({Key key,
    @required this.onActionSelected,
    @required this.allowEdit,
    @required this.allowShare,
    @required this.allowUnshare,
    @required this.allowDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        if (allowShare)
          IconButton(
            icon: Icon(WebMailIcons.shared_with_all),
            tooltip: i18n(context, "contacts_view_app_bar_share"),
            onPressed: () => onActionSelected(ContactViewAppBarAction.share),
          ),
        if (allowUnshare)
          IconButton(
            icon: Icon(WebMailIcons.unshare),
            tooltip: i18n(context, "contacts_view_app_bar_unshare"),
            onPressed: () => onActionSelected(ContactViewAppBarAction.unshare),
          ),
        IconButton(
          icon: Icon(Icons.attach_file),
          tooltip: i18n(context, "contacts_view_app_bar_attach"),
          onPressed: () => onActionSelected(ContactViewAppBarAction.attach),
        ),
//        IconButton(
//          icon: Icon(MdiIcons.emailSearchOutline),
//          tooltip: i18n(context, "contacts_view_app_bar_search_messages"),
////          onPressed: () => onActionSelected(ContactViewAppBarAction.searchMessages),
//          onPressed: null,
//        ),
        if (allowEdit)
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: i18n(context, "contacts_view_app_bar_edit_contact"),
            onPressed: () => onActionSelected(ContactViewAppBarAction.edit),
          ),
        if (allowDelete)
          IconButton(
            icon: Icon(Icons.delete_outline),
            tooltip: i18n(context, "contacts_view_app_bar_delete_contact"),
            onPressed: () => onActionSelected(ContactViewAppBarAction.delete),
          ),
      ],
    );
  }
}
