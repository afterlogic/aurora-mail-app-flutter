import 'package:aurora_mail/main.dart' as main;
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/theming/app_theme.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info/package_info.dart';

import 'app_navigation.dart';
import 'auth/blocs/auth_bloc/bloc.dart';
import 'auth/screens/login/login_route.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final _authBloc = new AuthBloc();
  final _settingsBloc = new SettingsBloc();
  PackageInfo _appInfo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initApp();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      main.isBackground = true;
    } else if (state == AppLifecycleState.resumed) {
      main.isBackground = false;
      _settingsBloc.add(OnResume());
    }
    super.didChangeAppLifecycleState(state);
  }

  void _initApp() async {
    _appInfo = await PackageInfo.fromPlatform();
    _authBloc.add(InitUserAndAccounts());
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _settingsBloc.add(UpdateConnectivity(result));
    });
  }

  ThemeData _getTheme(bool isDarkTheme) {
    if (isDarkTheme == false)
      return AppTheme.light;
    else if (isDarkTheme == true)
      return AppTheme.dark;
    else
      return null;
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
                  final theme = _getTheme(settingsState.darkThemeEnabled);

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
                      title: _appInfo.appName,
                      onGenerateRoute: AppNavigation.onGenerateRoute,
                      theme: theme ?? AppTheme.light,
                      darkTheme: theme ?? AppTheme.dark,
                      localizationsDelegates: [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        FlutterI18nDelegate(
                          useCountryCode: false,
                          fallbackFile: "en",
                          path: "assets/flutter_i18n",
                          forcedLocale: settingsState.language?.toLocale(),
                        ),
                      ],
                      supportedLocales: supportedLocales,
                      localeResolutionCallback: (locale, locales) {
                        final supportedLocale = locales.firstWhere((l) {
                          return l.languageCode == locale.languageCode;
                        }, orElse: () => null);

                        return supportedLocale ?? Locale("en", "");
                      },
                      locale: settingsState.language?.toLocale(),
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
      },
    );
  }
}
