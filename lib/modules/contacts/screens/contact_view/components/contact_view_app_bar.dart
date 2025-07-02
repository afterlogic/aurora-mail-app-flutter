//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/res/icons/webmail_icons.dart';
import 'package:aurora_mail/shared_ui/app_bar_icons.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:theme/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ContactViewAppBarAction {
  attach,
  find_in_email,
  searchMessages,
  edit,
  share,
  unshare,
  add_to_group,
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
    String customIconPath,
  }) {
    Widget iconWidget;
    if (BuildProperty.useCustomAppBarIcons && customIconPath != null) {
      iconWidget = SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/$customIconPath',
        width: 24.0,
        height: 24.0,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : null,
      );
    } else {
      iconWidget = Icon(
        icon,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : null,
      );
    }
    
    return PopupMenuItem(
      child: ListTile(
        leading: iconWidget,
        title: Text(text),
      ),
      value: value,
    );
  }

    final actions = <Widget>[
      PopupMenuButton(
        icon: AppBarIcons.menu(),
        onSelected: onActionSelected,
        itemBuilder: (_) => [
          if (hasEmail)
            _buildMenuItem(
              value: ContactViewAppBarAction.find_in_email,
              text: S.of(context).btn_contact_find_in_email,
              icon: Icons.search,
              customIconPath: 'menu-find-in-email.svg',
            ),
          if (allowShare)
            _buildMenuItem(
              icon: WebMailIcons.shared_with_all,
              text: S.of(context).contacts_view_app_bar_share,
              value: ContactViewAppBarAction.share,
              customIconPath: 'menu-share.svg',
            ),
          if (allowUnshare)
            _buildMenuItem(
              icon: WebMailIcons.unshare,
              text: S.of(context).contacts_view_app_bar_unshare,
              value: ContactViewAppBarAction.unshare,
              customIconPath: 'unshare.svg',
            ),
          _buildMenuItem(
            icon: Icons.attach_file,
            text: S.of(context).contacts_view_app_bar_attach,
            value: ContactViewAppBarAction.attach,
            customIconPath: 'menu-attach.svg',
          ),
          if (allowEdit)
            _buildMenuItem(
              icon: Icons.edit,
              text: S.of(context).contacts_view_app_bar_edit_contact,
              value: ContactViewAppBarAction.edit,
              customIconPath: 'menu-edit.svg',
            ),
          _buildMenuItem(
            icon: MdiIcons.fileMove,
            text: S.of(context).contacts_group_add_to_group,
            value: ContactViewAppBarAction.add_to_group,
            customIconPath: 'menu-add-to-group.svg',
          ),
          if (allowDelete)
            _buildMenuItem(
              icon: Icons.delete_outline,
              text: S.of(context).contacts_view_app_bar_delete_contact,
              value: ContactViewAppBarAction.delete,
              customIconPath: 'menu-delete.svg',
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
        backgroundColor: AppColor.appBarBackground,
        textStyle: TextStyle(
            color: Color(0xFF2D2D2D),
            fontSize: 18,
            fontWeight: FontWeight.w600),
        shadow: BoxShadow(color: Colors.transparent),
        leading: IconButton(
          icon: AppBarIcons.back(),
          onPressed: () => Navigator.of(context).pop(),
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
