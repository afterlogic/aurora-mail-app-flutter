import 'dart:io';

import 'package:aurora_mail/modules/settings/models/language.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageSelectionDialog extends StatelessWidget {
  final Language selectedItem;
  final Function(Language) onItemSelected;

  const LanguageSelectionDialog(this.onItemSelected, this.selectedItem);

  static void show(BuildContext context, Language selected,
      Function(Language) onItemSelected) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (_) => LanguageSelectionDialog(onItemSelected, selected));
    } else {
      showDialog(
          context: context,
          builder: (_) => LanguageSelectionDialog(onItemSelected, selected));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActionSheet(
        title: Text(i18n(context, "settings_language")),
        actions: Language.availableLanguages
            .map((lang) => CupertinoButton(
                  child: Text(lang.name),
                  onPressed: () {
                    onItemSelected(lang);
                    Navigator.pop(context);
                  },
                ))
            .toList(),
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
        title: Text(i18n(context, "settings_language")),
        content: SizedBox(
          height: 56.0 * Language.availableLanguages.length,
          width: 350.0,
          child: ListView(
              children: Language.availableLanguages
                  .map((lang) => RadioListTile(
                        title: Text(lang == null
                            ? i18n(context, "settings_language_system")
                            : lang.name),
                        value: lang?.tag,
                        groupValue: selectedItem?.tag,
                        onChanged: (val) {
                          onItemSelected(lang);
                          Navigator.pop(context);
                        },
                      ))
                  .toList()),
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
