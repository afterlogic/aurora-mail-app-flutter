import 'dart:io';

import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeSelectionDialog extends StatelessWidget {
  final bool theme;
  final Function(bool) onItemSelected;

  const ThemeSelectionDialog(this.onItemSelected, this.theme);

  static void show(
      BuildContext context, bool selected, Function(bool) onItemSelected) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (_) => ThemeSelectionDialog(onItemSelected, selected));
    } else {
      showDialog(
          context: context,
          builder: (_) => ThemeSelectionDialog(onItemSelected, selected));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActionSheet(
        title: Text(i18n(context, "settings_dark_theme")),
        actions: [
          CupertinoButton(
            child: Text(i18n(context, "settings_dark_theme_system")),
            onPressed: () {
              onItemSelected(null);
              Navigator.pop(context);
            },
          ),
          CupertinoButton(
            child: Text(i18n(context, "settings_dark_theme_dark")),
            onPressed: () {
              onItemSelected(true);
              Navigator.pop(context);
            },
          ),
          CupertinoButton(
            child: Text(i18n(context, "settings_dark_theme_light")),
            onPressed: () {
              onItemSelected(false);
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoButton(
          child: Text(i18n(context, "btn_cancel")),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    } else {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.all(24.0),
        title: Text(i18n(context, "settings_dark_theme")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<bool>(
              title: Text(i18n(context, "settings_dark_theme_system")),
              value: null,
              groupValue: theme,
              onChanged: (val) {
                onItemSelected(null);
                Navigator.pop(context);
              },
            ),
            RadioListTile<bool>(
              title: Text(i18n(context, "settings_dark_theme_dark")),
              value: true,
              groupValue: theme,
              onChanged: (val) {
                onItemSelected(true);
                Navigator.pop(context);
              },
            ),
            RadioListTile<bool>(
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
            child: Text(i18n(context, "btn_cancel").toUpperCase()),
            onPressed: Navigator.of(context).pop,
          ),
        ],
      );
    }
  }
}
