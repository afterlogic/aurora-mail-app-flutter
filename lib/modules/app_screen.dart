import 'package:aurora_mail/background/background_helper.dart';
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/shared_ui/restart_widget.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:theme/app_theme.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

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

  final _navKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    WebMailApi.authErrorStream.listen((_) {
      _authBloc.add(InvalidateCurrentUserToken());
    });
    BackgroundHelper.current = AppLifecycleState.resumed;
    _initApp();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    BackgroundHelper.current = state;

    if (state == AppLifecycleState.resumed) {
      _settingsBloc.add(OnResume());
    }

    super.didChangeAppLifecycleState(state);
  }

  void _initApp() async {
    _authBloc.add(InitUserAndAccounts());

    final connectivity = new Connectivity();

    connectivity.checkConnectivity().then((res) {
      _settingsBloc.add(UpdateConnectivity(res));
    });

    connectivity.onConnectivityChanged.listen((result) {
      _settingsBloc.add(UpdateConnectivity(result));
    });
  }

  void _navigateToLogin() {
    _navKey.currentState.popUntil((r) => r.isFirst);
    _navKey.currentState.pushReplacementNamed(LoginRoute.name);
    RestartWidget.restartApp(context);
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
//    _authBloc.close();
//    _settingsBloc.close();
    BackgroundHelper.current = AppLifecycleState.detached;
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (_, state) {
        if (state is LoggedOut) _navigateToLogin();
        if (state is UserSelected) RestartWidget.restartApp(context);
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        bloc: _authBloc,
        condition: (_, state) => state is InitializedUserAndAccounts,
        builder: (_, authState) {
          if (authState is InitializedUserAndAccounts) {
            if (authState.user != null) {
              _settingsBloc.add(InitSettings(authState.user, authState.users));
            }
            return BlocBuilder<SettingsBloc, SettingsState>(
                bloc: _settingsBloc,
                builder: (_, settingsState) {
                  if (settingsState is SettingsLoaded) {
                    final theme = _getTheme(settingsState.darkThemeEnabled);

                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: _authBloc),
                        BlocProvider.value(value: _settingsBloc),
                        BlocProvider(
                          create: (_) => new MailBloc(
                            user: _authBloc.currentUser,
                            account: _authBloc.currentAccount,
                          ),
                        ),
                        BlocProvider(
                          create: (_) => new ContactsBloc(
                            user: _authBloc.currentUser,
                            appDatabase: DBInstances.appDB,
                          ),
                        ),
                      ],
                      child: MaterialApp(
                        navigatorKey: _navKey,
                        onGenerateTitle: (context) {
                          final is24 =
                              MediaQuery.of(context).alwaysUse24HourFormat;
                          if (settingsState.is24 == null) {
                            _settingsBloc.add(SetTimeFormat(is24));
                          }
                          return BuildProperty.appName;
                        },
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
                            return locale != null &&
                                l.languageCode == locale.languageCode;
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
      ),
    );
  }
}
