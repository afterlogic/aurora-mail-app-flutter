
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/shared_ui/adaptive_contact_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:theme/app_color.dart';

import 'adaptive_action_button.dart';

enum InfoAction { email, call, visitWebsite, none }

class ContactsInfoItem extends StatelessWidget {
  final IconData icon;
  final String? iconName;
  final String label;
  final String value;
  final InfoAction action;
  final VoidCallback? onTap;

  ContactsInfoItem({
    required this.icon,
    this.iconName,
    required this.label,
    required this.value,
    this.action = InfoAction.none,
    this.onTap,
  }) : super(key: Key(value));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(width: 16.0),
          iconName?.isNotEmpty == true
              ? AdaptiveContactIcon(
                  defaultIcon: icon,
                  iconName: iconName,
                  color: theme.primaryColor,
                )
              : Icon(icon, color: theme.primaryColor),
          SizedBox(width: 22.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(value,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: BuildProperty.useCustomContactIcons
                          ? AppColor.contactsPrimary
                          : null,
                    )),
                SizedBox(height: 5.0),
                Text(
                  label,
                  style: TextStyle(fontSize: 12.0, color: theme.disabledColor),
                ),
              ],
            ),
          ),
          _buildAction(),
        ],
      ),
    );
  }

  Widget _buildAction() {
    switch (action) {
      case InfoAction.email:
        return AdaptiveActionButton(
          fallbackIcon: MdiIcons.emailOutline,
          iconName: 'email',
          onTap: onTap,
        );
      case InfoAction.call:
        return AdaptiveActionButton(
          fallbackIcon: MdiIcons.phone,
          iconName: 'phone',
          onTap: onTap,
        );
      case InfoAction.visitWebsite:
        return AdaptiveActionButton(
          fallbackIcon: MdiIcons.web,
          iconName: 'web-page',
          onTap: onTap,
        );
      case InfoAction.none:
        return SizedBox();
      default:
        return SizedBox();
    }
  }
}
