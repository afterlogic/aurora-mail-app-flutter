import 'dart:io';

import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeSelectionDialog extends StatelessWidget {
  final bool theme;
  final Function(bool) onItemSelected;

  const ThemeSelectionDialog(this.onItemSelected, this.theme);

  static void show(
      BuildContext context, bool selected, Function(bool) onItemSelected) {
    dialog(
        context: context,
        builder: (_) => ThemeSelectionDialog(onItemSelected, selected));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.all(24.0),
      title: Text(i18n(context, "settings_dark_theme")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<bool>(
            activeColor: Theme.of(context).accentColor,
            title: Text(i18n(context, "settings_dark_theme_system")),
            value: null,
            groupValue: theme,
            onChanged: (val) {
              onItemSelected(null);
              Navigator.pop(context);
            },
          ),
          RadioListTile<bool>(
            activeColor: Theme.of(context).accentColor,
            title: Text(i18n(context, "settings_dark_theme_dark")),
            value: true,
            groupValue: theme,
            onChanged: (val) {
              onItemSelected(true);
              Navigator.pop(context);
            },
          ),
          RadioListTile<bool>(
            activeColor: Theme.of(context).accentColor,
            title: Text(i18n(context, "settings_dark_theme_light")),
            value: false,
            groupValue: theme,
            onChanged: (val) {
              onItemSelected(false);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          textColor: Theme.of(context).brightness == Brightness.light ? Theme.of(context).accentColor : null,
          child: Text(i18n(context, "btn_cancel")),
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
