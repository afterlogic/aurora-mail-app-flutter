import 'package:aurora_mail/modules/settings/screens/common_settings/common_settings_route.dart';
import 'package:aurora_mail/modules/settings/screens/sync_settings/sync_settings_route.dart';
import 'package:flutter/material.dart';

class SettingsMainAndroid extends StatefulWidget {
  @override
  _SettingsMainAndroidState createState() => _SettingsMainAndroidState();
}

class _SettingsMainAndroidState extends State<SettingsMainAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO translate
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.tune),
            title: Text("Common"),
            onTap: () => Navigator.pushNamed(context, CommonSettingsRoute.name),
          ),
          ListTile(
            leading: Icon(Icons.sync),
            title: Text("Sync"),
            onTap: () => Navigator.pushNamed(context, SyncSettingsRoute.name),
          ),
        ],
      ),
    );
  }
}
