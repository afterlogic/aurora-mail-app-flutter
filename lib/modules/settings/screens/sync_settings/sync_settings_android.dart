//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/models/sync_freq.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/modules/settings/screens/sync_settings/components/freq_selection_dialog.dart';
import 'package:aurora_mail/shared_ui/adaptive_settings_menu_icon.dart';
import 'package:aurora_mail/shared_ui/app_bar_icons.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:theme/app_color.dart';

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

  // Custom divider for sync settings
  Widget _buildDivider() {
    if (BuildProperty.useSettingsMenuDivider) {
      return Divider(height: 1, thickness: 0.5, color: Colors.grey[300]);
    }
    return SizedBox.shrink();
  }

  // Custom trailing arrow for sync settings
  Widget _buildTrailingArrow() {
    if (BuildProperty.useSettingsMenuTrailingArrow) {
      Color arrowColor = theme.primaryColor;
      if (BuildProperty.useCustomSettingsColors) {
        final isDarkTheme = theme.brightness == Brightness.dark;
        arrowColor = isDarkTheme
            ? AppColor.settingsArrowDark
            : AppColor.settingsArrowLight;
      }

      return SvgPicture.asset(
        '${BuildProperty.image_dir}/settings/vector.svg',
        width: 8,
        height: 16,
        color: arrowColor,
      );
    }
    return SizedBox.shrink();
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
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: AppBarIcons.back(),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(S.of(context).settings_sync),
              backgroundColor: AppColor.appBarBackground,
              shadow: BoxShadow(color: Colors.transparent),
            ),
      body: Column(
        children: [
          if (BuildProperty.useAppBarDivider && !isTablet)
            Container(
              height: 1,
              color: AppColor.appBarDivider,
            ),
          Expanded(
            child: BlocBuilder<SettingsBloc, SettingsState>(
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
                          leading: AdaptiveSettingsMenuIcon(
                            defaultIcon: Icons.av_timer,
                            iconName: 'sync-frequency',
                            iconFolder: 'sync',
                            color: theme.primaryColor,
                            background: iconBG,
                          ),
                          title: Text(S.of(context).settings_sync_frequency),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                SyncFreq.freqToString(context, freq),
                                style: theme.textTheme.caption,
                              ),
                              SizedBox(width: 8),
                              _buildTrailingArrow(),
                            ],
                          ),
                          onTap: () => _onFreqDurationSelected(context, freq),
                        ),
                      if (BuildProperty.backgroundSync) _buildDivider(),
                      ListTile(
                        leading: AdaptiveSettingsMenuIcon(
                          defaultIcon: MdiIcons.calendarSync,
                          iconName: 'sync-period',
                          iconFolder: 'sync',
                          color: theme.primaryColor,
                          background: iconBG,
                        ),
                        title: Text(S.of(context).settings_sync_period),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              SyncPeriod.periodToTitle(context, period),
                              style: theme.textTheme.caption,
                            ),
                            SizedBox(width: 8),
                            _buildTrailingArrow(),
                          ],
                        ),
                        onTap: () => _onPeriodSelected(context, period),
                      ),
                      _buildDivider(),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
