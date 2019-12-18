import 'dart:io';

import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FreqSelectionDialog extends StatelessWidget {
  final Freq selectedItem;
  final Function(Freq) onItemSelected;

  const FreqSelectionDialog(this.selectedItem, this.onItemSelected);

  static void show(
      BuildContext context, Freq selectedItem, Function(Freq) onItemSelected) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (_) => FreqSelectionDialog(selectedItem, onItemSelected));
    } else {
      showDialog(
          context: context,
          builder: (_) => FreqSelectionDialog(selectedItem, onItemSelected));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActionSheet(
        title: Text(i18n(context, "settings_sync_frequency")),
        actions: Freq.values
            .map((freq) => CupertinoButton(
                  child: Text(SyncFreq.freqToString(context, freq)),
                  onPressed: () {
                    onItemSelected(freq);
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
        title: Text(i18n(context, "settings_sync_frequency")),
        content: SizedBox(
          height: 250.0,
          width: 400.0,
          child: ListView(
            children: Freq.values.map((freq) {
              return RadioListTile(
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
