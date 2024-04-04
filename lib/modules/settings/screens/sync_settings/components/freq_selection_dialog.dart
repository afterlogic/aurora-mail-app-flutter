import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/settings/models/sync_freq.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/foundation.dart';
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
    final theme = Theme.of(context);
    final values = Freq.values
        .getRange(0, kDebugMode ? Freq.values.length : Freq.values.length - 1);
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.all(24.0),
      title: Text(S.of(context).settings_sync_frequency),
      content: AMDialogList(
        children: values.map((freq) {
          return RadioListTile(
            activeColor: theme.primaryColor,
            title: Text(SyncFreq.freqToString(context, freq)!),
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
