//@dart=2.9
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'info_action_button.dart';

enum InfoAction { email, call, visitWebsite, none }

class ContactsInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final InfoAction action;
  final void Function() cb;

  ContactsInfoItem({
    @required this.icon,
    @required this.label,
    @required this.value,
    this.action = InfoAction.none,
    this.cb,
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
          Icon(icon, color: theme.accentColor),
          SizedBox(width: 22.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(value,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0)),
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
        assert(cb != null);
        return InfoActionButton(icon: MdiIcons.emailOutline, cb: cb);
      case InfoAction.call:
        assert(cb != null);
        return InfoActionButton(icon: MdiIcons.phone, cb: cb);
      case InfoAction.visitWebsite:
        assert(cb != null);
        return InfoActionButton(icon: MdiIcons.web, cb: cb);
      case InfoAction.none:
        assert(cb == null);
        return SizedBox();
      default:
        assert(cb == null);
        return SizedBox();
    }
  }
}
