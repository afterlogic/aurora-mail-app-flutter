import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAndroid extends StatefulWidget {
  @override
  _AboutAndroidState createState() => _AboutAndroidState();
}

class _AboutAndroidState extends BState<AboutAndroid> {
  bool loading = false;
  String _version;
  String _buildNumber;
  String _appName;

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
    _appName = packageInfo.appName;
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AMAppBar(title: Text(i18n(context, "settings_about"))),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(_appName, style: theme.textTheme.title),
                SizedBox(height: 12.0),
                Text(
                  i18n(context, "settings_about_app_version",
                      {"version": "$_version+$_buildNumber"}),
                  style: theme.textTheme.caption.copyWith(fontSize: 14.0),
                ),
                SizedBox(height: 22.0),
                Center(
                  child: SizedBox(
                    width: 120.0,
                    height: 120.0,
                    child: Image.asset(BuildProperty.icon),
                  ),
                ),
                SizedBox(height: 42.0),
                GestureDetector(
                  child: Text(
                    i18n(context, "settings_about_terms_of_service"),
                    style: TextStyle(
                      color: theme.accentColor,
                      decoration: TextDecoration.underline,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () => launch(BuildProperty.termsOfService),
                ),
                SizedBox(height: 22.0),
                GestureDetector(
                  child: Text(
                    i18n(context, "settings_about_privacy_policy"),
                    style: TextStyle(
                      color: theme.accentColor,
                      decoration: TextDecoration.underline,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () => launch(BuildProperty.privacyPolicy),
                ),
                SizedBox(height: 42.0),
              ],
            ),
    );
  }
}
