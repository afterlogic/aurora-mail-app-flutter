//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
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
      title: Text(S.of(context).settings_dark_theme),
      content: AMDialogList(
        children: [
          RadioListTile<bool>(
            activeColor: theme.primaryColor,
            title: Text(S.of(context).settings_dark_theme_system),
            value: null,
            groupValue: isTheme,
            onChanged: (val) {
              onItemSelected(null);
              Navigator.pop(context);
            },
          ),
          RadioListTile<bool>(
            activeColor: theme.primaryColor,
            title: Text(S.of(context).settings_dark_theme_dark),
            value: true,
            groupValue: isTheme,
            onChanged: (val) {
              onItemSelected(true);
              Navigator.pop(context);
            },
          ),
          RadioListTile<bool>(
            activeColor: theme.primaryColor,
            title: Text(S.of(context).settings_dark_theme_light),
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
        TextButton(
          child: Text(
            S.of(context).btn_cancel,
            style: TextStyle(
                color: theme.brightness == Brightness.light
                    ? theme.primaryColor
                    : null),
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
