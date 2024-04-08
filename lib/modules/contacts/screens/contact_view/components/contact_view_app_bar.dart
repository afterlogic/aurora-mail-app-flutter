//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/res/icons/webmail_icons.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';

enum ContactViewAppBarAction {
  attach,
  find_in_email,
  searchMessages,
  edit,
  share,
  unshare,
  delete
}

class ContactViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final bool allowEdit;
  final bool allowShare;
  final bool allowUnshare;
  final bool allowDelete;
  final bool hasEmail;
  final Function(ContactViewAppBarAction) onActionSelected;
  final bool isAppBar;
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const ContactViewAppBar({
    Key key,
    @required this.name,
    @required this.onActionSelected,
    @required this.allowEdit,
    @required this.allowShare,
    @required this.allowUnshare,
    @required this.allowDelete,
    this.hasEmail,
    this.isAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PopupMenuEntry<ContactViewAppBarAction> _buildMenuItem({
      @required ContactViewAppBarAction value,
      @required String text,
      @required IconData icon,
    }) {
      return PopupMenuItem(
        child: ListTile(
          leading: Icon(icon, color: Theme.of(context).brightness == Brightness.light ? Colors.black : null,),
          title: Text(text),
        ),
        value: value,
      );
    }

    final actions = <Widget>[
      PopupMenuButton(
        onSelected: onActionSelected,
        itemBuilder: (_) => [
          if (hasEmail)
            _buildMenuItem(
              value: ContactViewAppBarAction.find_in_email,
              text: S.of(context).btn_contact_find_in_email,
              icon: Icons.search,
            ),
          if (allowShare)
            _buildMenuItem(
              icon: WebMailIcons.shared_with_all,
              text: S.of(context).contacts_view_app_bar_share,
              value: ContactViewAppBarAction.share,
            ),
          if (allowUnshare)
            _buildMenuItem(
              icon: WebMailIcons.unshare,
              text: S.of(context).contacts_view_app_bar_unshare,
              value: ContactViewAppBarAction.unshare,
            ),
          _buildMenuItem(
            icon: Icons.attach_file,
            text: S.of(context).contacts_view_app_bar_attach,
            value: ContactViewAppBarAction.attach,
          ),
//            _buildMenuItem(
//              icon: MdiIcons.emailSearchOutline,
//              text: i18n(context, "contacts_view_app_bar_search_messages"),
//              value: ContactViewAppBarAction.searchMessages,
//            ),
          if (allowEdit)
            _buildMenuItem(
              icon: Icons.edit,
              text: S.of(context).contacts_view_app_bar_edit_contact,
              value: ContactViewAppBarAction.edit,
            ),
          if (allowDelete)
            _buildMenuItem(
              icon: Icons.delete_outline,
              text: S.of(context).contacts_view_app_bar_delete_contact,
              value: ContactViewAppBarAction.delete,
            ),
        ],
      ),
    ];
    if (isAppBar) {
      return AMAppBar(
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: actions,
      );
    } else {
      return SizedBox(
        height: 50,
        child: ListTile(
          title: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          trailing: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: actions),
        ),
      );
    }
  }
}
