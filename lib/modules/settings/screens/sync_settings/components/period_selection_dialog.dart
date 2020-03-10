import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/cupertino.dart';
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
      title: Text(i18n(context, "settings_sync_period")),
      content: AMDialogList(
        children: Period.values.map((period) {
          return RadioListTile(
            activeColor: theme.accentColor,
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
