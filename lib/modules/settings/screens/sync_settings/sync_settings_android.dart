import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/models/sync_freq.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/modules/settings/screens/sync_settings/components/freq_selection_dialog.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'components/period_selection_dialog.dart';

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

  void _onPeriodSelected(BuildContext context, Period selected) {
    PeriodSelectionDialog.show(context, selected, (period) {
      BlocProvider.of<SettingsBloc>(context).add(SetPeriod(period));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text(i18n(context, "settings_sync")),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        bloc: BlocProvider.of<SettingsBloc>(context),
        condition: (_, state) => state is SettingsLoaded,
        builder: (_, state) {
          if (state is SettingsLoaded) {
            final freq = SyncFreq.secondsToFreq(state.syncFrequency);
            final period = SyncPeriod.dbStringToPeriod(state.syncPeriod);
            return ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.av_timer),
                  title: Text(i18n(context, "settings_sync_frequency")),
                  trailing: Text(
                    SyncFreq.freqToString(context, freq),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onTap: () => _onFreqDurationSelected(context, freq),
                ),
                ListTile(
                  leading: Icon(MdiIcons.calendarRepeat),
                  title: Text(i18n(context, "settings_sync_period")),
                  trailing: Text(
                    SyncPeriod.periodToTitle(context, period),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onTap: () => _onPeriodSelected(context, period),
                ),
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
