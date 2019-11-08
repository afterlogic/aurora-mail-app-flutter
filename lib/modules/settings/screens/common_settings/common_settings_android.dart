import 'package:flutter/material.dart';

class CommonSettingsAndroid extends StatefulWidget {
  @override
  _CommonSettingsAndroidState createState() => _CommonSettingsAndroidState();
}

class _CommonSettingsAndroidState extends State<CommonSettingsAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO translate
      appBar: AppBar(title: Text("Common")),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.translate),
            title: Text("Language"),
          )
        ],
      ),
    );
  }
}
