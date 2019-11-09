import 'dart:io';

import 'package:aurora_mail/modules/settings/blocs/sync_settings/bloc.dart';
import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FreqSelectionDialog extends StatelessWidget {
  final Function(SyncDuration) onItemSelected;

  const FreqSelectionDialog(this.onItemSelected);

  static void show(
      BuildContext context, Function(SyncDuration) onItemSelected) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (_) => FreqSelectionDialog(onItemSelected));
    } else {
      showDialog(
          context: context,
          builder: (_) => FreqSelectionDialog(onItemSelected));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO translate
    final actions = [
      SyncDuration("never", Duration(days: 9999999999999)),
      SyncDuration("1 minute", Duration(minutes: 1)),
      SyncDuration("5 minutes", Duration(minutes: 5)),
      SyncDuration("1 hour", Duration(hours: 1)),
      SyncDuration("2 hour", Duration(hours: 2)),
      SyncDuration("daily", Duration(days: 1)),
      SyncDuration("monthly", Duration(days: 30)),
    ];

    if (Platform.isIOS) {
      return CupertinoActionSheet(
        title: Text("Sync frequency"),
        actions: actions
            .map((sync) => CupertinoButton(
                  child: Text(sync.title),
                  onPressed: () {
                    onItemSelected(sync);
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
          title: Text("Sync frequency"),
          content: SizedBox(
            height: 310.0,
            width: 400.0,
            child: ListView(
              children: actions.map((sync) {
                return RadioListTile(
                  title: Text(sync.title),
                  value: sync.title,
                  groupValue: BlocProvider.of<SyncSettingsBloc>(context),
                  onChanged: (val) {
                    onItemSelected(sync);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ));
    }
  }
}
