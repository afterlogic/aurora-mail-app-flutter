import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/models/sync_freq.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/modules/settings/screens/sync_settings/components/freq_selection_dialog.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'components/period_selection_dialog.dart';

class SyncSettingsAndroid extends StatefulWidget {
  @override
  _SyncSettingsAndroidState createState() => _SyncSettingsAndroidState();
}

class _SyncSettingsAndroidState extends BState<SyncSettingsAndroid> {
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
    final isTablet = LayoutConfig.of(context).isTablet;
    final iconBG = theme.brightness == Brightness.dark
        ? theme.colorScheme.onPrimary.withOpacity(0.20)
        : theme.colorScheme.primary.withOpacity(0.08);
    return Scaffold(
      appBar: isTablet
          ? null
          : AMAppBar(
              title: Text(S.of(context).settings_sync),
            ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        bloc: BlocProvider.of<SettingsBloc>(context),
        buildWhen: (_, state) => state is SettingsLoaded,
        builder: (_, state) {
          if (state is SettingsLoaded) {
            final freq = SyncFreq.secondsToFreq(state.syncFrequency);
            final period = SyncPeriod.dbStringToPeriod(state.syncPeriod);
            return ListView(
              children: <Widget>[
                if (BuildProperty.backgroundSync)
                  ListTile(
                    leading: AMCircleIcon(
                      Icons.av_timer,
                      color: theme.primaryColor,
                      background: iconBG,
                    ),
                    title: Text(S.of(context).settings_sync_frequency),
                    trailing: Text(
                      SyncFreq.freqToString(context, freq)!,
                      style: theme.textTheme.caption,
                    ),
                    onTap: () => _onFreqDurationSelected(context, freq),
                  ),
                ListTile(
                  leading: AMCircleIcon(
                    MdiIcons.calendarSync,
                    color: theme.primaryColor,
                    background: iconBG,
                  ),
                  title: Text(S.of(context).settings_sync_period),
                  trailing: Text(
                    SyncPeriod.periodToTitle(context, period),
                    style: theme.textTheme.caption,
                  ),
                  onTap: () => _onPeriodSelected(context, period),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
