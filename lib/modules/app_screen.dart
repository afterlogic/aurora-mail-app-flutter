import 'dart:async';

import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/auth/state/auth_state.dart';
import 'package:aurora_mail/modules/mail/mail_route.dart';
import 'package:aurora_mail/theming/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'app_navigation.dart';
import 'auth/auth_route.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AuthState _authState = AppStore.authState;
  Future<List<bool>> _localStorageInitialization;

  @override
  void initState() {
    super.initState();
    _initLocalStorage();
  }

  Future _initLocalStorage() async {
    _localStorageInitialization = Future.wait([
      _authState.getAuthSharedPrefs(),
    ]);
  }

  bool _canEnterMainApp(List<bool> localStorageInitializationResults) {
    if (localStorageInitializationResults == null) return false;
    bool canEnterMailApp = true;
    localStorageInitializationResults.forEach((result) {
      if (result == null || result == false) canEnterMailApp = false;
    });
    return canEnterMailApp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _localStorageInitialization,
        builder: (_, AsyncSnapshot<List<bool>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return MaterialApp(
                title: "Aurora Mail",
                onGenerateRoute: AppNavigation.onGenerateRoute,
                theme: AppTheme.light,
                initialRoute: _canEnterMainApp(snapshot.data)
                    ? MailRoute.name
                    : AuthRoute.name,
            );
          } else if (snapshot.hasError) {
            final err = snapshot.error.toString();
            return Material(
                child: Center(
                    child: SelectableText(
                        "Could not start the app, please make a screenshot of the error and send it to support@afterlogic.com and we'll fix it!\nERROR: $err")));
          } else {
            return Material();
          }
        });
  }
}
