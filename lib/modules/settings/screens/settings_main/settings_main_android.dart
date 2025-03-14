//@dart=2.9
import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_event.dart';
import 'package:aurora_mail/modules/route_generator.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart';
import 'package:aurora_mail/modules/settings/screens/about/about_route.dart';
import 'package:aurora_mail/modules/settings/screens/common_settings/common_settings_route.dart';
import 'package:aurora_mail/modules/settings/screens/debug/debug_route.dart';
import 'package:aurora_mail/modules/settings/screens/manage_users/manage_users_route.dart';
import 'package:aurora_mail/modules/settings/screens/notifications_settings/notifications_settings_route.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/pgp_settings_route.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_navigator.dart';
import 'package:aurora_mail/modules/settings/screens/sync_settings/sync_settings_route.dart';
import 'package:aurora_mail/shared_ui/mail_bottom_app_bar.dart';
import 'package:aurora_mail/shared_ui/optional_dialog.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsMainAndroid extends StatefulWidget {
  @override
  _SettingsMainAndroidState createState() => _SettingsMainAndroidState();
}

class _SettingsMainAndroidState extends BState<SettingsMainAndroid> {
  bool showDebug = false;
  final storage = LoggerStorage();
  final navigatorKey = GlobalKey<SettingsNavigatorState>();
  PgpSettingsBloc pgpSettingsBloc;

  @override
  initState() {
    super.initState();
    storage.getDebugEnable().then((value) => setState(() => showDebug = value));
    pgpSettingsBloc = AppInjector.instance
        .pgpSettingsBloc(BlocProvider.of<AuthBloc>(context));
  }

  @override
  void dispose() {
    pgpSettingsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconBG = theme.brightness == Brightness.dark
        ? theme.colorScheme.onPrimary.withOpacity(0.20)
        : theme.colorScheme.primary.withOpacity(0.08);
    final isTablet = LayoutConfig.of(context).isTablet;
    final current = isTablet
        ? (navigatorKey?.currentState?.current?.name ??
            CommonSettingsRoute.name)
        : null;
    Widget body = ListView(
      children: <Widget>[
        ListTile(
          selected: current == CommonSettingsRoute.name,
          leading: AMCircleIcon(
            Icons.tune,
            color: theme.primaryColor,
            background: iconBG,
          ),
          title: Text(S.of(context).settings_common),
          onTap: () => navigator().setRoot(CommonSettingsRoute.name),
        ),
        ListTile(
          selected: current == SyncSettingsRoute.name,
          leading: AMCircleIcon(Icons.sync,
            color: theme.primaryColor,
            background: iconBG,),
          title: Text(S.of(context).settings_sync),
          onTap: () => navigator().setRoot(SyncSettingsRoute.name),
        ),
        if (BuildProperty.enablePushNotification && BuildProperty.showPushNotificatonsSettings)
          ListTile(
            selected: current == NotificationsSettingsRoute.name,
            leading: AMCircleIcon(Icons.notifications,
              color: theme.primaryColor,
              background: iconBG,),
            title: Text(S.of(context).label_notifications_settings),
            onTap: () => navigator().setRoot(NotificationsSettingsRoute.name),
          ),
        if (BuildProperty.cryptoEnable)
          ListTile(
            selected: current == PgpSettingsRoute.name,
            leading: AMCircleIcon(Icons.vpn_key,
              color: theme.primaryColor,
              background: iconBG,),
            title: Text(S.of(context).label_pgp_settings),
            onTap: () => navigator().setRoot(
              PgpSettingsRoute.name,
              arguments: PgpSettingsRouteArg(pgpSettingsBloc),
            ),
          ),
        if (BuildProperty.multiUserEnable)
          ListTile(
            selected: current == ManageUsersRoute.name,
            leading: AMCircleIcon(Icons.account_circle,
              color: theme.primaryColor,
              background: iconBG,),
            title: Text(S.of(context).settings_accounts_manage),
            onTap: () => navigator().setRoot(ManageUsersRoute.name),
          ),
        ListTile(
          selected: current == AboutRoute.name,
          leading: AMCircleIcon(Icons.info_outline,
            color: theme.primaryColor,
            background: iconBG,),
          title: Text(S.of(context).settings_about),
          onLongPress: BuildProperty.enableDebugScreen
              ? () {
                  storage.setDebugEnable(true);
                  setState(() => showDebug = true);
                }
              : null,
          onTap: () => navigator().setRoot(AboutRoute.name),
        ),
        if (showDebug)
          ListTile(
            selected: current == DebugRoute.name,
            leading: AMCircleIcon(Icons.perm_device_information,
              color: theme.primaryColor,
              background: iconBG,),
            title: Text("Debug"),
            onTap: () => navigator().setRoot(DebugRoute.name),
          ),
        if (!BuildProperty.multiUserEnable)
          ListTile(
            leading: AMCircleIcon(Icons.exit_to_app,
              color: theme.primaryColor,
              background: iconBG,),
            title: Text(S.of(context).messages_list_app_bar_logout),
            onTap: _exit,
          ),
      ],
    );
    if (isTablet) {
      body = Scaffold(
        appBar: AMAppBar(
          title: Text(S.of(context).settings),
        ),
        body: Row(
          children: [
            ClipRRect(
              child: SizedBox(
                width: 304,
                child: Scaffold(
                  body: DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(
                        border: Border(right: BorderSide(width: 0.2))),
                    child: Drawer(
                      child: ListTileTheme(
                        style: ListTileStyle.drawer,
                        selectedColor: theme.primaryColor,
                        child: SafeArea(child: body),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: ClipRRect(
                child: Scaffold(
                  body: SettingsNavigatorWidget(
                    key: navigatorKey,
                    onUpdate: () {
                      setState(() {});
                    },
                    initialRoute: CommonSettingsRoute.name,
                    routeFactory: RouteGenerator.onGenerateRoute,
                  ),
                ),
              ),
              flex: 3,
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: isTablet
          ? null
          : AMAppBar(
              title: Text(S.of(context).settings),
            ),
      body: body,
      bottomNavigationBar:
          MailBottomAppBar(selectedRoute: MailBottomAppBarRoutes.settings),
    );
  }

  _exit() async {
    final clearCacheText = S.of(context).clear_cache_during_logout;
    final result = await showDialog(
      context: context,
      builder: (_) => OptionalDialog(
        title: S.of(context).hint_confirm_exit,
        options: {clearCacheText: true},
        actionText: S.of(context).btn_exit,
      ),
    );
    if (result is OptionalDialogResult && result.generalResult == true) {
      final authBloc = BlocProvider.of<AuthBloc>(context);
      if (result.options[clearCacheText] == true) {
        authBloc.add(DeleteUser(authBloc.currentUser));
      } else {
        authBloc.add(InvalidateCurrentUserToken());
      }
    }
  }

  SettingsNavigator navigator() {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState;
    } else {
      return SettingsNavigatorMock(Navigator.of(context));
    }
  }
}
