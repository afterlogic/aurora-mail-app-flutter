//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/utils/base_state.dart';
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
  String _appName;

  @override
  void initState() {
    super.initState();
    _initAppInfo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isTablet = LayoutConfig.of(context).isTablet;
    if (!isTablet) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
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
    if (packageInfo.version != null && packageInfo.buildNumber != null) {
      _version = "${packageInfo.version}+${packageInfo.buildNumber}";
    } else {
      _version = '${BuildProperty.version} + ${BuildProperty.build}';
    }
    _appName = packageInfo.appName ?? BuildProperty.appName;
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = LayoutConfig.of(context).isTablet;
    return Scaffold(
      appBar: isTablet
          ? null
          : AMAppBar(title: Text(S.of(context).settings_about)),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(_appName, style: theme.textTheme.headline6),
                SizedBox(height: 12.0),
                Text(
                  S.of(context).settings_about_app_version(_version),
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
                if (BuildProperty.termsOfService.isNotEmpty)
                  GestureDetector(
                    child: Text(
                      S.of(context).settings_about_terms_of_service,
                      style: TextStyle(
                        color: theme.accentColor,
                        decoration: TextDecoration.underline,
                        fontSize: 18.0,
                      ),
                    ),
                    onTap: () => launch(BuildProperty.termsOfService),
                  ),
                if (BuildProperty.termsOfService.isNotEmpty)
                  SizedBox(height: 22.0),
                if (BuildProperty.privacyPolicy.isNotEmpty)
                  GestureDetector(
                    child: Text(
                      S.of(context).settings_about_privacy_policy,
                      style: TextStyle(
                        color: theme.accentColor,
                        decoration: TextDecoration.underline,
                        fontSize: 18.0,
                      ),
                    ),
                    onTap: () => launch(BuildProperty.privacyPolicy),
                  ),
                if (BuildProperty.privacyPolicy.isNotEmpty)
                  SizedBox(height: 42.0),
              ],
            ),
    );
  }
}
