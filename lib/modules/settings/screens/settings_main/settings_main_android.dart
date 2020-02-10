import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_event.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_state.dart';
import 'package:aurora_mail/modules/settings/screens/about/about_route.dart';
import 'package:aurora_mail/modules/settings/screens/common_settings/common_settings_route.dart';
import 'package:aurora_mail/modules/settings/screens/manage_users/manage_users_route.dart';
import 'package:aurora_mail/modules/settings/screens/sync_settings/sync_settings_route.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:aurora_mail/build_property.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsMainAndroid extends StatefulWidget {
  @override
  _SettingsMainAndroidState createState() => _SettingsMainAndroidState();
}

class _SettingsMainAndroidState extends State<SettingsMainAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(i18n(context, "settings"))),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.tune),
            title: Text(i18n(context, "settings_common")),
            onTap: () => Navigator.pushNamed(context, CommonSettingsRoute.name),
          ),
          ListTile(
            leading: Icon(Icons.sync),
            title: Text(i18n(context, "settings_sync")),
            onTap: () => Navigator.pushNamed(context, SyncSettingsRoute.name),
          ),
          if (BuildProperty.multiUserEnable)
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(i18n(context, "settings_accounts_manage")),
              onTap: () => Navigator.pushNamed(context, ManageUsersRoute.name),
            ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(i18n(context, "settings_about")),
            onTap: () => Navigator.pushNamed(context, AboutRoute.name),
          ),
          if (!BuildProperty.multiUserEnable)
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(i18n(context, "messages_list_app_bar_logout")),
              onTap: () => BlocProvider.of<AuthBloc>(context).add(LogOut()),
            ),
        ],
      ),
    );
  }
}
