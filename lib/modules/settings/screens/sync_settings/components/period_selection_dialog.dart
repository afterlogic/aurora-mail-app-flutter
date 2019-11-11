import 'dart:io';

import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PeriodSelectionDialog extends StatelessWidget {
  final Period selectedItem;
  final Function(Period) onItemSelected;

  const PeriodSelectionDialog(this.selectedItem, this.onItemSelected);

  static void show(
      BuildContext context, Period selectedItem, Function(Period) onItemSelected) {
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
        title: Text("Sync period"),
        actions: Period.values
            .map((period) => CupertinoButton(
                  child: Text(SyncPeriod.periodToTitle(period)),
                  onPressed: () {
                    onItemSelected(period);
                    Navigator.pop(context);
                  },
                ))
            .toList(),
        cancelButton: CupertinoButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    } else {
      return AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.all(24.0),
          title: Text("Sync period"),
          content: SizedBox(
            height: 310.0,
            width: 400.0,
            child: ListView(
              children: Period.values.map((period) {
                return RadioListTile(
                  title: Text(SyncPeriod.periodToTitle(period)),
                  value: period,
                  groupValue: selectedItem,
                  onChanged: (val) {
                    onItemSelected(period);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ));
    }
  }
}
