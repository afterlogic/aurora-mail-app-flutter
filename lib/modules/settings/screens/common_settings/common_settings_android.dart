//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/models/language.dart';
import 'package:aurora_mail/modules/settings/screens/common_settings/components/theme_selection_dialog.dart';
import 'package:aurora_mail/shared_ui/adaptive_settings_menu_icon.dart';
import 'package:aurora_mail/shared_ui/app_bar_icons.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/app_color.dart';

import 'components/language_selection_dialog.dart';

class CommonSettingsAndroid extends StatefulWidget {
  @override
  _CommonSettingsAndroidState createState() => _CommonSettingsAndroidState();
}

class _CommonSettingsAndroidState extends BState<CommonSettingsAndroid> {
  // Custom divider for common settings
  Widget _buildDivider() {
    if (BuildProperty.useSettingsMenuDivider) {
      return Divider(height: 1, thickness: 0.5, color: Colors.grey[300]);
    }
    return SizedBox.shrink();
  }

  // Custom trailing arrow for common settings
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
    // ignore: close_sinks
    final iconBG = theme.brightness == Brightness.dark
        ? theme.colorScheme.onPrimary.withOpacity(0.20)
        : theme.colorScheme.primary.withOpacity(0.08);
    final bloc = BlocProvider.of<SettingsBloc>(context);
    final isTablet = LayoutConfig.of(context).isTablet;
    return Scaffold(
      appBar: isTablet
          ? null
          : AMAppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: AppBarIcons.back(context: context),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(S.of(context).settings_common),
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
              builder: (_, state) {
                if (state is SettingsLoaded) {
                  return ListView(
                    children: <Widget>[
                      SwitchListTile.adaptive(
                          title: Row(
                            children: <Widget>[
                              AdaptiveSettingsMenuIcon(
                                defaultIcon: Icons.access_time,
                                iconName: '24-hour-format',
                                iconFolder: 'common',
                                color: theme.primaryColor,
                                background: iconBG,
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: Text(
                                    S.of(context).settings_24_time_format,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                          activeColor: theme.primaryColor,
                          value: state.is24,
                          onChanged: (val) => bloc.add(SetTimeFormat(val))),
                      _buildDivider(),
                      if (BuildProperty.showThemeSelection)
                        ListTile(
                          leading: AdaptiveSettingsMenuIcon(
                            defaultIcon: Icons.color_lens,
                            iconName: 'app-theme',
                            iconFolder: 'common',
                            color: theme.primaryColor,
                            background: iconBG,
                          ),
                          title: Text(S.of(context).settings_dark_theme),
                          trailing: _buildTrailingArrow(),
                          onTap: () => ThemeSelectionDialog.show(
                              context,
                              state.darkThemeEnabled,
                              (val) => bloc.add(SetDarkTheme(val))),
                        ),
                      if (BuildProperty.showThemeSelection) _buildDivider(),
                      if (Language.availableLanguages.length > 2)
                        ListTile(
                          leading: AdaptiveSettingsMenuIcon(
                            defaultIcon: Icons.translate,
                            iconName: 'language',
                            iconFolder: 'common',
                            color: theme.primaryColor,
                            background: iconBG,
                          ),
                          title: Text(S.of(context).settings_language),
                          trailing: _buildTrailingArrow(),
                          onTap: () => LanguageSelectionDialog.show(
                              context,
                              state.language,
                              (lang) => bloc.add(SetLanguage(lang))),
                        ),
                      if (Language.availableLanguages.length > 2)
                        _buildDivider(),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
