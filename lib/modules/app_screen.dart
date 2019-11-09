import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/blocs/common_settings/bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/sync_settings/bloc.dart';
import 'package:aurora_mail/theming/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_navigation.dart';
import 'auth/blocs/auth/bloc.dart';
import 'auth/screens/login/login_route.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _authBloc = new AuthBloc();

  @override
  void initState() {
    super.initState();
    _authBloc.add(InitUserAndAccounts());
  }

  @override
  void dispose() {
    super.dispose();
    _authBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        bloc: _authBloc,
        condition: (_, state) => state is InitializedUserAndAccounts,
        builder: (_, state) {
          if (state is InitializedUserAndAccounts) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>.value(
                  value: _authBloc,
                ),
                BlocProvider<CommonSettingsBloc>(
                  builder: (_) => CommonSettingsBloc(),
                ),
                BlocProvider<SyncSettingsBloc>(
                  builder: (_) => SyncSettingsBloc(),
                ),
              ],
              child: MaterialApp(
                title: "Aurora Mail",
                onGenerateRoute: AppNavigation.onGenerateRoute,
                theme: AppTheme.light,
                initialRoute:
                    state.needsLogin ? LoginRoute.name : MessagesListRoute.name,
              ),
            );
          } else {
            return Material();
          }
        });
  }
}
