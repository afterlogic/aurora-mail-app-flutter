import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'components/language_selection_dialog.dart';

class CommonSettingsAndroid extends StatefulWidget {
  @override
  _CommonSettingsAndroidState createState() => _CommonSettingsAndroidState();
}

class _CommonSettingsAndroidState extends State<CommonSettingsAndroid> {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<SettingsBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).settings_common)),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (_, state) {
          if (state is SettingsLoaded) {
            return ListView(
              children: <Widget>[
                SwitchListTile.adaptive(
                  value: state.darkThemeEnabled,
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (bool val) => bloc.add(SetDarkTheme(val)),
                  title: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(MdiIcons.themeLightDark),
                    title: Text(S.of(context).settings_dark_theme),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.translate),
                  title: Text(S.of(context).settings_language),
                  onTap: () => LanguageSelectionDialog.show(context,
                      state.language, (lang) => bloc.add(SetLanguage(lang))),
                  trailing: Text(
                    state.language == null
                        ? S.of(context).settings_language_system
                        : state.language.name,
                    style: Theme.of(context).textTheme.caption,
                  ),
                )
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
