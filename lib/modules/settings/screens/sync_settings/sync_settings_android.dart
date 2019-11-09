import 'package:aurora_mail/modules/settings/blocs/sync_settings/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/sync_settings/components/freq_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SyncSettingsAndroid extends StatefulWidget {
  @override
  _SyncSettingsAndroidState createState() => _SyncSettingsAndroidState();
}

class _SyncSettingsAndroidState extends State<SyncSettingsAndroid> {
  void _onFreqDurationSelected(BuildContext context) {
    FreqSelectionDialog.show(context, (duration) {
      BlocProvider.of<SyncSettingsBloc>(context).add(SetFrequency(duration));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO translate
      appBar: AppBar(title: Text("Sync")),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.av_timer),
            title: Text("Sync frequency"),
            onTap: () => _onFreqDurationSelected(context),
          )
        ],
      ),
    );
  }
}
