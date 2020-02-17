import 'dart:io';

import 'package:aurora_mail/modules/settings/models/sync_freq.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FreqSelectionDialog extends StatelessWidget {
  final Freq selectedItem;
  final Function(Freq) onItemSelected;

  const FreqSelectionDialog(this.selectedItem, this.onItemSelected);

  static void show(
      BuildContext context, Freq selectedItem, Function(Freq) onItemSelected) {
      dialog(
          context: context,
          builder: (_) => FreqSelectionDialog(selectedItem, onItemSelected));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.all(24.0),
      title: Text(i18n(context, "settings_sync_frequency")),
      content: AMDialogList(
        children: Freq.values.map((freq) {
          return RadioListTile(
            activeColor: Theme.of(context).accentColor,
            title: Text(SyncFreq.freqToString(context, freq)),
            value: freq,
            groupValue: selectedItem,
            onChanged: (val) {
              onItemSelected(freq);
              Navigator.pop(context);
            },
          );
        }).toList(),
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
