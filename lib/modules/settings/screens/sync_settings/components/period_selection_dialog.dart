import 'dart:io';

import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PeriodSelectionDialog extends StatelessWidget {
  final Period selectedItem;
  final Function(Period) onItemSelected;

  const PeriodSelectionDialog(this.selectedItem, this.onItemSelected);

  static void show(BuildContext context, Period selectedItem,
      Function(Period) onItemSelected) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (_) => PeriodSelectionDialog(selectedItem, onItemSelected));
    } else {
      showDialog(
          context: context,
          builder: (_) => PeriodSelectionDialog(selectedItem, onItemSelected));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActionSheet(
        title: Text(i18n(context, "settings_sync_period")),
        actions: Period.values
            .map((period) => CupertinoButton(
                  child: Text(SyncPeriod.periodToTitle(context, period)),
                  onPressed: () {
                    onItemSelected(period);
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
        title: Text(i18n(context, "settings_sync_period")),
        content: SizedBox(
          height: 56.0 * Period.values.length,
          width: 400.0,
          child: ListView(
            children: Period.values.map((period) {
              return RadioListTile(
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
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(i18n(context, "btn_cancel")),
            onPressed: Navigator.of(context).pop,
          ),
        ],
      );
    }
  }
}
