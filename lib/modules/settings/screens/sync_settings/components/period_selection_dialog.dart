import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';

class PeriodSelectionDialog extends StatelessWidget {
  final Period selectedItem;
  final Function(Period) onItemSelected;

  const PeriodSelectionDialog(this.selectedItem, this.onItemSelected);

  static void show(BuildContext context, Period selectedItem,
      Function(Period) onItemSelected) {
    dialog(
        context: context,
        builder: (_) => PeriodSelectionDialog(selectedItem, onItemSelected));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.all(24.0),
      title: Text(S.of(context).settings_sync_period),
      content: AMDialogList(
        children: Period.values.map((period) {
          return RadioListTile(
            activeColor: theme.primaryColor,
            title: Text(SyncPeriod.periodToTitle(context, period)),
            value: period,
            groupValue: selectedItem,
            onChanged: (val) {
              onItemSelected(period);
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
