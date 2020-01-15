import 'package:aurora_mail/utils/internationalization.dart';
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
  String _version;
  String _buildNumber;

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
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(i18n(context, "settings_about"))),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(i18n(context, "app_title"), style: Theme.of(context).textTheme.title),
                SizedBox(height: 12.0),
                Text(
                  i18n(context, "settings_about_app_version", {"version": "$_version+$_buildNumber"}),
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
                    child: Image.asset("assets/images/ic_launcher.png"),
                  ),
                ),
                SizedBox(height: 42.0),
                GestureDetector(
                  child: Text(
                    i18n(context, "settings_about_terms_of_service"),
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      decoration: TextDecoration.underline,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () => launch(
                      "https://afterlogic.com/products/webmail-pro-licensing"),
                ),
                SizedBox(height: 22.0),
                GestureDetector(
                  child: Text(
                    i18n(context, "settings_about_privacy_policy"),
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
