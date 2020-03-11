import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeSelectionDialog extends StatelessWidget {
  final bool isTheme;
  final Function(bool) onItemSelected;

  const ThemeSelectionDialog(this.onItemSelected, this.isTheme);

  static void show(
      BuildContext context, bool selected, Function(bool) onItemSelected) {
    dialog(
        context: context,
        builder: (_) => ThemeSelectionDialog(onItemSelected, selected));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.all(24.0),
      title: Text(i18n(context, "settings_dark_theme")),
      content: AMDialogList(
        children: [
          RadioListTile<bool>(
            activeColor: theme.accentColor,
            title: Text(i18n(context, "settings_dark_theme_system")),
            value: null,
            groupValue: isTheme,
            onChanged: (val) {
              onItemSelected(null);
              Navigator.pop(context);
            },
          ),
          RadioListTile<bool>(
            activeColor: theme.accentColor,
            title: Text(i18n(context, "settings_dark_theme_dark")),
            value: true,
            groupValue: isTheme,
            onChanged: (val) {
              onItemSelected(true);
              Navigator.pop(context);
            },
          ),
          RadioListTile<bool>(
            activeColor: theme.accentColor,
            title: Text(i18n(context, "settings_dark_theme_light")),
            value: false,
            groupValue: isTheme,
            onChanged: (val) {
              onItemSelected(false);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          textColor:
              theme.brightness == Brightness.light ? theme.accentColor : null,
          child: Text(i18n(context, "btn_cancel")),
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
