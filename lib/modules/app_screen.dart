
import 'dart:async';
import 'dart:io';

import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/background/background_helper.dart';
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/models/server_modules.dart';
import 'package:aurora_mail/modules/app_route_observer.dart';
import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/notification/calendar_notification_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/tasks/tasks_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/calendar_page.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/calendar_route.dart';
import 'package:aurora_mail/modules/calendar/utils/week_start_converter.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_android.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/notification/models/notification_data.dart';
import 'package:aurora_mail/notification/models/notification_type.dart';
import 'package:aurora_mail/notification/push_notifications_manager.dart';
import 'package:aurora_mail/shared_ui/restart_widget.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/user_app_data_singleton.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:receive_sharing/recive_sharing.dart';
import 'package:theme/app_theme.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

import 'auth/blocs/auth_bloc/bloc.dart';
import 'auth/screens/login/login_android.dart';
import 'auth/screens/login/login_route.dart';
import 'dialog_wrap.dart';
import 'route_generator.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends BState<App> with WidgetsBindingObserver {
  final _authBloc = new AuthBloc();
  final _settingsBloc = new SettingsBloc();
  StreamSubscription? sub;
  final _navKey = GlobalKey<NavigatorState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  NotificationData? _notification;

  /// Becomes true once we've observed a logged-in user this app session, so
  /// we can tell "the current session was invalidated" (must force the user
  /// back to the login screen) apart from "there was never a session to
  /// begin with" (already showing the login screen, nothing to do).
  bool _hadUser = false;

  /// Set right before invalidating the token in response to a server auth
  /// error, so [_navigateToLogin] knows to explain to the user why they were
  /// signed out (as opposed to a deliberate manual sign-out).
  bool _authErrorLogout = false;

  @override
  void initState() {
    super.initState();
    _notification = PushNotificationsManager.instance.initNotification;
    if (_notification != null) {
      switch (_notification!.type) {
        case NotificationType.event:
          CalendarPage.activityType = ActivityType.event;
          CalendarPage.selectedCalendarId = _notification!.calendarId;
          CalendarPage.selectedActivityId = _notification!.activityId;
          break;
        case NotificationType.task:
          CalendarPage.activityType = ActivityType.task;
          CalendarPage.selectedCalendarId = _notification!.calendarId;
          CalendarPage.selectedActivityId = _notification!.activityId;
          break;
        case NotificationType.email:
          MessagesListAndroid.openMessageFolder = _notification!.folder;
          MessagesListAndroid.openMessageId = _notification!.messageId;
          break;
      }
    }
    WidgetsBinding.instance.addObserver(this);
    BackgroundHelper.current = WidgetsBinding.instance.lifecycleState!;
    sub = WebMailApi.authErrorStream.listen((_) {
      if (_authBloc.currentUser != null) {
        _authErrorLogout = true;
        _authBloc.add(InvalidateCurrentUserToken());
      }
    });
    _initApp();
    ReceiveSharing.getInitialMedia().then((shared) {
      if (shared.isEmpty) return;
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
        _navKey.currentState!.pushNamedAndRemoveUntil(
          MessagesListRoute.name,
          (value) => false,
        );
      }
    }, onError: (Object e, StackTrace st) {
      Logger.errorLog(e, st);
    }).catchError((Object e, StackTrace st) {
      Logger.errorLog(e, st);
    });

    try {
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
            _navKey.currentState!.popUntil(
              (value) => value.settings.name == MessagesListRoute.name,
            );
            MessagesListAndroid.onShare!(files, texts);
          } else {
            MessagesListAndroid.shareHolder = [files, texts];
            _navKey.currentState!.pushNamedAndRemoveUntil(
              MessagesListRoute.name,
              (value) => false,
            );
          }
        }
      });
    } catch (e, st) {
      Logger.errorLog(e, st);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    BackgroundHelper.current = state;

    if (state == AppLifecycleState.resumed) {
      DBInstances.appDB.notifyMailTableUpdated();
      _settingsBloc.add(OnResume());
    }

    super.didChangeAppLifecycleState(state);
  }

  void _initApp() async {
    _authBloc.add(InitUserAndAccounts());
    _authBloc.add(UpdateAccounts(null));
    final connectivity = new Connectivity();

    connectivity.checkConnectivity().then((res) {
      _settingsBloc.add(UpdateConnectivity(
          res.isNotEmpty ? res.first : ConnectivityResult.none));
    });

    connectivity.onConnectivityChanged.listen((result) {
      _settingsBloc.add(UpdateConnectivity(
          result.isNotEmpty ? result.first : ConnectivityResult.none));
    });
  }

  void _navigateToLogin() {
    try {
      // RestartWidget below tears down and recreates the whole widget tree
      // (including the Navigator), so this has to be a static field the
      // fresh LoginAndroid reads on init rather than a route argument
      if (_authErrorLogout) {
        LoginAndroid.pendingMessage = S.current.error_session_expired;
      }
      _authErrorLogout = false;
      _navKey.currentState!.popUntil((r) => r.isFirst);
      _navKey.currentState!.pushReplacementNamed(LoginRoute.name);
      RestartWidget.restartApp(context);
    } catch (e) {
      print(e);
    }
  }

  ThemeData? _getTheme(bool? isDarkTheme) {
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
    BackgroundHelper.current = WidgetsBinding.instance.lifecycleState!;
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
            if (state.user != null) {
              _hadUser = true;
            } else if (_hadUser) {
              // the session that was active this app run just got
              // invalidated (server-side auth error or manual sign-out) -
              // force the user back to the login screen instead of letting
              // them keep browsing already-downloaded, cached mail
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
                      final calendarRepository = authState.user != null &&
                              BuildProperty.calendarModule &&
                              (UserAppDataSingleton()
                                      .getAppData
                                      ?.hasModule(ServerModules.calendar) ??
                                  false)
                          ? CalendarRepository(
                              user: _authBloc.currentUser!,
                              appDB: DBInstances.appDB)
                          : null;
                      final calendarUseCase = calendarRepository != null
                          ? CalendarUseCase(
                              repository: calendarRepository,
                              location:
                                  UserAppDataSingleton().getAppData?.location)
                          : null;
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: _authBloc),
                          BlocProvider.value(value: _settingsBloc),
                          if (calendarUseCase != null)
                            BlocProvider(
                              lazy: false,
                              create: (_) => EventsBloc(
                                  useCase: calendarUseCase,
                                  firstDayInWeek: convert(UserAppDataSingleton()
                                      .getAppData
                                      ?.calendarSettings!["WeekStartsOn"]))
                                ..add(const StartSync()),
                            ),
                          if (calendarUseCase != null)
                            BlocProvider(
                              lazy: false,
                              create: (_) =>
                                  CalendarsBloc(useCase: calendarUseCase)
                                    ..add(const FetchCalendars()),
                            ),
                          if (calendarUseCase != null)
                            BlocProvider(
                              create: (_) =>
                                  TasksBloc(useCase: calendarUseCase),
                            ),
                          if (calendarUseCase != null)
                            BlocProvider(
                              create: (_) => CalendarNotificationBloc(
                                  useCase: calendarUseCase),
                            ),
                          BlocProvider(
                            create: (_) => MailBloc(
                              user: _authBloc.currentUser!,
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
                              user: _authBloc.currentUser!,
                              appDatabase: DBInstances.appDB,
                            )..add(GetContacts()),
                          ),
                        ],
                        child: MaterialApp(
                          debugShowCheckedModeBanner: true,
                          navigatorKey: _navKey,
                          scaffoldMessengerKey: _scaffoldMessengerKey,
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
                          ],
                          supportedLocales: BuildProperty.supportLanguage
                              .split(",")
                              .map((item) => Locale(item))
                              .toList(),
                          localeResolutionCallback: (locale, locales) {
                            final supportedLocale = locales.firstWhereOrNull((l) {
                              return locale != null &&
                                  l.languageCode == locale.languageCode;
                            });

                            return supportedLocale ?? locales.first;
                          },
                          locale: settingsState.language?.toLocale(),
                          initialRoute: authState.needsLogin
                              ? LoginRoute.name
                              : _notification != null &&
                                      (_notification!.type ==
                                              NotificationType.event ||
                                          _notification!.type ==
                                              NotificationType.task)
                                  ? CalendarRoute.name
                                  : MessagesListRoute.name,
                          navigatorObservers: [AppRouteObserver()],
                          builder: (context, child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                textScaler: TextScaler.noScaling,
                              ),
                              child: LoggerControllerWidget.wrap(
                                child ?? const SizedBox.shrink(),
                                bottomPadding:
                                    MediaQuery.of(context).viewPadding.bottom,
                              ),
                            );
                          },
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
