//@dart=2.9
import 'package:aurora_mail/modules/settings/models/language.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageSelectionDialog extends StatelessWidget {
  final Language selectedItem;
  final Function(Language) onItemSelected;

  const LanguageSelectionDialog(this.onItemSelected, this.selectedItem);

  static void show(BuildContext context, Language selected,
      Function(Language) onItemSelected) {
    dialog(
        context: context,
        builder: (_) => LanguageSelectionDialog(onItemSelected, selected));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.all(24.0),
      title: Text(i18n(context, S.settings_language)),
      content: AMDialogList(
        children: Language.availableLanguages
            .map(
              (lang) => RadioListTile(
                activeColor: theme.accentColor,
                title: Text(lang == null
                    ? i18n(context, S.settings_language_system)
                    : lang.name),
                value: lang?.tag,
                groupValue: selectedItem?.tag,
                onChanged: (val) {
                  onItemSelected(lang);
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            i18n(context, S.btn_cancel),
            style: TextStyle(
                color: theme.brightness == Brightness.light
                    ? theme.accentColor
                    : null),
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
