import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/common_settings/components/theme_selection_dialog.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/language_selection_dialog.dart';

class CommonSettingsAndroid extends StatefulWidget {
  @override
  _CommonSettingsAndroidState createState() => _CommonSettingsAndroidState();
}

class _CommonSettingsAndroidState extends BState<CommonSettingsAndroid> {

  String _getThemeName(bool isDarkTheme) {
    if (isDarkTheme == false)
      return i18n(context, "settings_dark_theme_light");
    else if (isDarkTheme == true)
      return i18n(context, "settings_dark_theme_dark");
    else
      return i18n(context, "settings_dark_theme_system");
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<SettingsBloc>(context);

    return Scaffold(
      appBar: AMAppBar(
        title: Text(i18n(context, "settings_common")),
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
                        child: Text(i18n(context, "settings_24_time_format"),
                        overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  activeColor: theme.accentColor,
                  value: state.is24,
                  onChanged: (val) => bloc.add(SetTimeFormat(val))),
                ListTile(
                  leading: AMCircleIcon(Icons.color_lens),
                  title: Text(i18n(context, "settings_dark_theme")),
                  onTap: () => ThemeSelectionDialog.show(
                      context,
                      state.darkThemeEnabled,
                      (val) => bloc.add(SetDarkTheme(val))),
                  trailing: Text(_getThemeName(state.darkThemeEnabled),
                    style: theme.textTheme.caption,
                  ),
                ),
                ListTile(
                  leading: AMCircleIcon(Icons.translate),
                  title: Text(i18n(context, "settings_language")),
                  onTap: () => LanguageSelectionDialog.show(context,
                      state.language, (lang) => bloc.add(SetLanguage(lang))),
                  trailing: Text(
                    state.language == null
                        ? i18n(context, "settings_language_system")
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
