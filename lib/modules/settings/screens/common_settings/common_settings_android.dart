import 'package:aurora_mail/generated/i18n.dart';
import 'package:flutter/material.dart';

class CommonSettingsAndroid extends StatefulWidget {
  @override
  _CommonSettingsAndroidState createState() => _CommonSettingsAndroidState();
}

class _CommonSettingsAndroidState extends State<CommonSettingsAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).settings_common)),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.translate),
            title: Text(S.of(context).settings_language),
          )
        ],
      ),
    );
  }
}
