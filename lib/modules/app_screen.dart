//@dart=2.9
import 'dart:async';
import 'dart:io';

import 'package:aurora_mail/background/background_helper.dart';
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/localization/localization_delegate.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_android.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/shared_ui/restart_widget.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';
import 'package:receive_sharing/recive_sharing.dart';
import 'package:theme/app_theme.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

import 'route_generator.dart';
import 'auth/blocs/auth_bloc/bloc.dart';
import 'auth/screens/login/login_route.dart';
import 'dialog_wrap.dart';

final routeObserver = RouteObserver();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends BState<App> with WidgetsBindingObserver {
  final _authBloc = new AuthBloc();
  final _settingsBloc = new SettingsBloc();
  StreamSubscription sub;
  final _navKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    BackgroundHelper.current = WidgetsBinding.instance.lifecycleState;
    sub = WebMailApi.authErrorStream.listen((_) {
      if (_authBloc.currentUser != null) {
        _authBloc.add(InvalidateCurrentUserToken());
      }
    });
    _initApp();
    ReceiveSharing.getInitialMedia().then((shared) {
      if (shared == null) return;
      final texts = <String>[];
      final files = <File>[];
      for (var value in shared) {
        if (value.isText) {
          texts.add(value.text);
        } else {
          files.add(File(value.path));
        }
      }
      if (texts.isNotEmpty || files.isNotEmpty) {
        MessagesListAndroid.shareHolder = [files, texts];
        _navKey.currentState.pushNamedAndRemoveUntil(
          MessagesListRoute.name,
          (value) => false,
        );
      }
    });
    ReceiveSharing.getMediaStream().listen((shared) {
      final texts = <String>[];
      final files = <File>[];
      for (var value in shared) {
        if (value.isText) {
          texts.add(value.text);
        } else {
          files.add(File(value.path));
        }
      }
      if (texts.isNotEmpty || files.isNotEmpty) {
        if (MessagesListAndroid.onShare != null) {
          _navKey.currentState.popUntil(
            (value) => value.settings.name == MessagesListRoute.name,
          );
          MessagesListAndroid.onShare(files, texts);
        } else {
          MessagesListAndroid.shareHolder = [files, texts];
          _navKey.currentState.pushNamedAndRemoveUntil(
            MessagesListRoute.name,
            (value) => false,
          );
        }
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    BackgroundHelper.current = state;

    if (state == AppLifecycleState.resumed) {
      DBInstances.appDB.streamQueries
          .handleTableUpdates({TableUpdate.onTable(DBInstances.appDB.mail)});
      _settingsBloc.add(OnResume());
    }

    super.didChangeAppLifecycleState(state);
  }

  void _initApp() async {
    _authBloc.add(InitUserAndAccounts());
    _authBloc.add(UpdateAccounts(null));
    final connectivity = new Connectivity();

    connectivity.checkConnectivity().then((res) {
      _settingsBloc.add(UpdateConnectivity(res));
    });

    connectivity.onConnectivityChanged.listen((result) {
      _settingsBloc.add(UpdateConnectivity(result));
    });
  }

  void _navigateToLogin() {

    try{
      _navKey.currentState.popUntil((r) => r.isFirst);
      _navKey.currentState.pushReplacementNamed(LoginRoute.name);
      RestartWidget.restartApp(context);
    }catch(e,st){
      print(e);
      print(st);
    }
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
    sub?.cancel();
    BackgroundHelper.current = WidgetsBinding.instance.lifecycleState;
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return RouteWrap(
      authBloc: _authBloc,
      navKey: _navKey,
      child: BlocListener<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (_, state) {
          if (state is LoggedOut) _navigateToLogin();
          if (state is UserSelected) RestartWidget.restartApp(context);
          if (state is InitializedUserAndAccounts) {
            if (state.user == null) {
              _navigateToLogin();
            }
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: _authBloc,
          buildWhen: (_, state) => state is InitializedUserAndAccounts,
          builder: (_, authState) {
            if (authState is InitializedUserAndAccounts) {
              if (authState.user != null) {
                _settingsBloc
                    .add(InitSettings(authState.user, authState.users));
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
                            create: (_) => MailBloc(
                              user: _authBloc.currentUser,
                              account: _authBloc.currentAccount,
                            ),
                          ),
                          BlocProvider(
                            create: (_) => MessagesListBloc(
                              user: _authBloc.currentUser,
                              account: _authBloc.currentAccount,
                            ),
                          ),
                          BlocProvider(
                            create: (_) => ContactsBloc(
                              user: _authBloc.currentUser,
                              appDatabase: DBInstances.appDB,
                            )..add(GetContacts()),
                          ),
                        ],
                        child: MaterialApp(
                          debugShowCheckedModeBanner: false,
                          navigatorKey: _navKey,
                          onGenerateTitle: (context) {
                            final is24 =
                                MediaQuery.of(context).alwaysUse24HourFormat;
                            if (settingsState.is24 == null) {
                              _settingsBloc.add(SetTimeFormat(is24));
                            }
                            return BuildProperty.appName;
                          },
                          onGenerateRoute: RouteGenerator.onGenerateRoute,
                          theme: theme ?? AppTheme.light,
                          darkTheme: theme ?? AppTheme.dark,
                          localizationsDelegates: [
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                            S.delegate,
                            LocalizationI18nDelegate(
                              forcedLocale: supportedLocales.contains(
                                      settingsState.language?.toLocale())
                                  ? settingsState.language?.toLocale()
                                  : null,
                            ),
                          ],
                          supportedLocales: supportedLocales,
                          localeResolutionCallback: (locale, locales) {
                            final supportedLocale = locales.firstWhere((l) {
                              return locale != null &&
                                  l.languageCode == locale.languageCode;
                            }, orElse: () => null);

                            return supportedLocale ??
                                locales.first ??
                                Locale("en", "");
                          },
                          locale: settingsState.language?.toLocale(),
                          initialRoute: authState.needsLogin
                              ? LoginRoute.name
                              : MessagesListRoute.name,
                          navigatorObservers: [routeObserver],
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
      ),
    );
  }
}
