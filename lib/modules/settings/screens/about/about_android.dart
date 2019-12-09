import 'dart:io';

import 'package:aurora_mail/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAndroid extends StatefulWidget {
  @override
  _AboutAndroidState createState() => _AboutAndroidState();
}

class _AboutAndroidState extends State<AboutAndroid> {
  bool loading = false;
  String _appName;
  String _version;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _initAppInfo();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future _initAppInfo() async {
    setState(() => loading = true);
    final packageInfo = await PackageInfo.fromPlatform();
    _appName = packageInfo.appName;
    _version = packageInfo.version;
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).settings_about)),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(_appName, style: Theme.of(context).textTheme.title),
                SizedBox(height: 12.0),
                Text(
                  S.of(context).settings_about_app_version(_version),
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 14.0),
                ),
                SizedBox(height: 22.0),
                Center(
                  child: SizedBox(
                    width: 120.0,
                    height: 120.0,
                    child: Image.asset("assets/images/app_icon.png"),
                  ),
                ),
                SizedBox(height: 42.0),
                GestureDetector(
                  child: Text(
                    S.of(context).settings_about_terms_of_service,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      decoration: TextDecoration.underline,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () => launch("https://afterlogic.com/products/webmail-pro-licensing"),
                ),
                SizedBox(height: 22.0),
                GestureDetector(
                  child: Text(
                    S.of(context).settings_about_privacy_policy,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      decoration: TextDecoration.underline,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () => launch("https://afterlogic.com/privacy-policy"),
                ),
                SizedBox(height: 42.0),
              ],
            ),
    );
  }
}
