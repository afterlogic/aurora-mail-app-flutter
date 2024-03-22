import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/models/language.dart';
import 'package:aurora_mail/modules/settings/screens/common_settings/components/theme_selection_dialog.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/language_selection_dialog.dart';

class CommonSettingsAndroid extends StatefulWidget {
  @override
  _CommonSettingsAndroidState createState() => _CommonSettingsAndroidState();
}

class _CommonSettingsAndroidState extends BState<CommonSettingsAndroid> {
  String _getThemeName(bool isDarkTheme) {
    if (isDarkTheme == false)
      return S.of(context).settings_dark_theme_light;
    else if (isDarkTheme == true)
      return S.of(context).settings_dark_theme_dark;
    else
      return S.of(context).settings_dark_theme_system;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<SettingsBloc>(context);
    final isTablet = LayoutConfig.of(context).isTablet;
    return Scaffold(
      appBar: isTablet
          ? null
          : AMAppBar(
              title: Text(S.of(context).settings_common),
            ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (_, state) {
          if (state is SettingsLoaded) {
            return ListView(
              children: <Widget>[
                SwitchListTile.adaptive(
                    title: Row(
                      children: <Widget>[
                        AMCircleIcon(Icons.access_time),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Text(S.of(context).settings_24_time_format,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    activeColor: theme.primaryColor,
                    value: state.is24,
                    onChanged: (val) => bloc.add(SetTimeFormat(val))),
                ListTile(
                  leading: AMCircleIcon(Icons.color_lens),
                  title: Text(S.of(context).settings_dark_theme),
                  onTap: () => ThemeSelectionDialog.show(
                      context,
                      state.darkThemeEnabled,
                      (val) => bloc.add(SetDarkTheme(val))),
                  trailing: Text(
                    _getThemeName(state.darkThemeEnabled),
                    style: theme.textTheme.caption,
                  ),
                ),
                if (Language.availableLanguages.length > 2)
                  ListTile(
                    leading: AMCircleIcon(Icons.translate),
                    title: Text(S.of(context).settings_language),
                    onTap: () => LanguageSelectionDialog.show(context,
                        state.language, (lang) => bloc.add(SetLanguage(lang))),
                    trailing: Text(
                      state.language == null
                          ? S.of(context).settings_language_system
                          : state.language.name,
                      style: theme.textTheme.caption,
                    ),
                  ),
              ],
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
