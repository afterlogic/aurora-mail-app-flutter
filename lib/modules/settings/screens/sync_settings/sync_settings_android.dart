import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:aurora_mail/modules/settings/screens/sync_settings/components/freq_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SyncSettingsAndroid extends StatefulWidget {
  @override
  _SyncSettingsAndroidState createState() => _SyncSettingsAndroidState();
}

class _SyncSettingsAndroidState extends State<SyncSettingsAndroid> {
  void _onFreqDurationSelected(BuildContext context, Freq selected) {
    FreqSelectionDialog.show(context, selected, (frequency) {
      BlocProvider.of<SettingsBloc>(context).add(SetFrequency(frequency));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO translate
      appBar: AppBar(title: Text("Sync")),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        bloc: BlocProvider.of<SettingsBloc>(context),
        condition: (_, state) => state is SettingsLoaded,
        builder: (_, state) {
          if (state is SettingsLoaded) {
            final freq = SyncFreq.secondsToFreq(state.frequency);
            return ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.av_timer),
                  // TODO translate
                  title: Text("Sync frequency"),
                  trailing: Text(
                    SyncFreq.freqToString(freq),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onTap: () => _onFreqDurationSelected(context, freq),
                )
              ],
            );
          } else {
            return null;
          }
        },
      ),
    );
  }
}
