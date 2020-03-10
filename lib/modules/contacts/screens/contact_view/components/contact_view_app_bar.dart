import 'package:aurora_mail/res/icons/webmail_icons.dart';
import 'package:aurora_mail/utils/internationalization.dart';
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AMAppBar(
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      actions: <Widget>[
        PopupMenuButton(
          onSelected: onActionSelected,
          itemBuilder: (_) => [
            if (hasEmail)
              _buildMenuItem(
                value: ContactViewAppBarAction.find_in_email,
                text: i18n(context, "find_in_email"),
                icon: Icons.search,
              ),
            if (allowShare)
              _buildMenuItem(
                icon: WebMailIcons.shared_with_all,
                text: i18n(context, "contacts_view_app_bar_share"),
                value: ContactViewAppBarAction.share,
              ),
            if (allowUnshare)
              _buildMenuItem(
                icon: WebMailIcons.unshare,
                text: i18n(context, "contacts_view_app_bar_unshare"),
                value: ContactViewAppBarAction.unshare,
              ),
            _buildMenuItem(
              icon: Icons.attach_file,
              text: i18n(context, "contacts_view_app_bar_attach"),
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
                text: i18n(context, "contacts_view_app_bar_edit_contact"),
                value: ContactViewAppBarAction.edit,
              ),
            if (allowDelete)
              _buildMenuItem(
                icon: Icons.delete_outline,
                text: i18n(context, "contacts_view_app_bar_delete_contact"),
                value: ContactViewAppBarAction.delete,
              ),
          ],
        ),
      ],
    );
  }

  PopupMenuEntry<ContactViewAppBarAction> _buildMenuItem({
    @required ContactViewAppBarAction value,
    @required String text,
    @required IconData icon,
  }) {
    return PopupMenuItem(
      child: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(width: 12.0),
          Text(text),
        ],
      ),
      value: value,
    );
  }
}
