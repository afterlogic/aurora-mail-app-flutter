import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CommonSettingsAndroid extends StatefulWidget {
  @override
  _CommonSettingsAndroidState createState() => _CommonSettingsAndroidState();
}

class _CommonSettingsAndroidState extends State<CommonSettingsAndroid> {
  @override
  Widget build(BuildContext context) {
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
                  onChanged: (bool val) =>
                      BlocProvider.of<SettingsBloc>(context)
                          .add(SetDarkTheme(val)),
                  title: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(MdiIcons.themeLightDark),
                    title: Text(S.of(context).settings_dark_theme),
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
