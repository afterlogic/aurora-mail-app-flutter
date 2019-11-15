import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/theming/app_theme.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_navigation.dart';
import 'auth/blocs/auth_bloc/bloc.dart';
import 'auth/screens/login/login_route.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _authBloc = new AuthBloc();
  final _settingsBloc = new SettingsBloc();

  @override
  void initState() {
    super.initState();
    _authBloc.add(InitUserAndAccounts());
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _settingsBloc.add(UpdateConnectivity(result));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _authBloc.close();
    _settingsBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        bloc: _authBloc,
        condition: (_, state) => state is InitializedUserAndAccounts,
        builder: (_, authState) {
          if (authState is InitializedUserAndAccounts) {
            if (authState.user != null) {
              _settingsBloc.add(InitSettings(authState.user));
            }
            return BlocBuilder<SettingsBloc, SettingsState>(
                bloc: _settingsBloc,
                builder: (_, settingsState) {
                  if (settingsState is SettingsLoaded) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<AuthBloc>.value(
                          value: _authBloc,
                        ),
                        BlocProvider<SettingsBloc>.value(
                          value: _settingsBloc,
                        ),
                      ],
                      child: MaterialApp(
                        title: "Aurora Mail",
                        onGenerateRoute: AppNavigation.onGenerateRoute,
                        theme: AppTheme.light,
                        localizationsDelegates: [S.delegate],
                        supportedLocales: S.delegate.supportedLocales,
                        initialRoute: authState.needsLogin
                            ? LoginRoute.name
                            : MessagesListRoute.name,
                      ),
                    );
                  } else {
                    return Material();
                  }
                });
          } else {
            return Material();
          }
        });
  }
}
