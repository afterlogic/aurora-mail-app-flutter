//@dart=2.9
import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_event.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
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
import 'package:aurora_mail/shared_ui/adaptive_settings_menu_icon.dart';
import 'package:aurora_mail/shared_ui/asset_svg_icon.dart';
import 'package:aurora_mail/shared_ui/mail_bottom_app_bar.dart';
import 'package:aurora_mail/shared_ui/optional_dialog.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // Custom divider for settings menu
  Widget _buildDivider() {
    // Show the separator only if custom icons are used.
    if (BuildProperty.useSettingsMenuDivider) {
      return Divider(height: 1, thickness: 0.5, color: Colors.grey[300]);
    }
    return SizedBox.shrink();
  }

  // Custom trailing arrow for settings menu
  Widget _buildTrailingArrow() {
    Color arrowColor = theme.primaryColor;
    if (BuildProperty.useCustomSettingsColors) {
      final isDarkTheme = theme.brightness == Brightness.dark;
      arrowColor = isDarkTheme
          ? AppColor.settingsArrowDark
          : AppColor.settingsArrowLight;
    }

    // Show the arrow only if custom icons are used.
    return AssetSvgIcon(
      showSvg: BuildProperty.useSettingsMenuTrailingArrow,
      svgPath: '${BuildProperty.image_dir}/settings/vector.svg',
      iconData: Icons.arrow_forward_ios,
      width: 8,
      height: 16,
      color: arrowColor,
    );
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
          leading: AdaptiveSettingsMenuIcon(
            defaultIcon: Icons.tune,
            iconName: 'common',
            color: theme.primaryColor,
            background: iconBG,
          ),
          title: Text(S.of(context).settings_common),
          trailing: _buildTrailingArrow(),
          onTap: () => navigator().setRoot(CommonSettingsRoute.name),
        ),
        _buildDivider(),
        ListTile(
          selected: current == SyncSettingsRoute.name,
          leading: AdaptiveSettingsMenuIcon(
            defaultIcon: Icons.sync,
            iconName: 'sync',
            color: theme.primaryColor,
            background: iconBG,
          ),
          title: Text(S.of(context).settings_sync),
          trailing: _buildTrailingArrow(),
          onTap: () => navigator().setRoot(SyncSettingsRoute.name),
        ),
        _buildDivider(),
        if (BuildProperty.enablePushNotification &&
            BuildProperty.showPushNotificatonsSettings)
          ListTile(
            selected: current == NotificationsSettingsRoute.name,
            leading: AdaptiveSettingsMenuIcon(
              defaultIcon: Icons.notifications,
              iconName: 'notifications',
              color: theme.primaryColor,
              background: iconBG,
            ),
            title: Text(S.of(context).label_notifications_settings),
            trailing: _buildTrailingArrow(),
            onTap: () => navigator().setRoot(NotificationsSettingsRoute.name),
          ),
        if (BuildProperty.enablePushNotification &&
            BuildProperty.showPushNotificatonsSettings)
          _buildDivider(),
        if (BuildProperty.cryptoEnable)
          ListTile(
            selected: current == PgpSettingsRoute.name,
            leading: AdaptiveSettingsMenuIcon(
              defaultIcon: Icons.vpn_key,
              iconName: 'openPGP',
              color: theme.primaryColor,
              background: iconBG,
            ),
            title: Text(S.of(context).label_pgp_settings),
            trailing: _buildTrailingArrow(),
            onTap: () => navigator().setRoot(
              PgpSettingsRoute.name,
              arguments: PgpSettingsRouteArg(pgpSettingsBloc),
            ),
          ),
        if (BuildProperty.cryptoEnable) _buildDivider(),
        if (BuildProperty.multiUserEnable)
          ListTile(
            selected: current == ManageUsersRoute.name,
            leading: AdaptiveSettingsMenuIcon(
              defaultIcon: Icons.account_circle,
              iconName: 'account',
              color: theme.primaryColor,
              background: iconBG,
            ),
            title: Text(S.of(context).settings_accounts_manage),
            trailing: _buildTrailingArrow(),
            onTap: () => navigator().setRoot(ManageUsersRoute.name),
          ),
        if (BuildProperty.multiUserEnable) _buildDivider(),
        ListTile(
          selected: current == AboutRoute.name,
          leading: AdaptiveSettingsMenuIcon(
            defaultIcon: Icons.info_outline,
            iconName: 'about',
            color: theme.primaryColor,
            background: iconBG,
          ),
          title: Text(S.of(context).settings_about),
          trailing: _buildTrailingArrow(),
          onLongPress: BuildProperty.enableDebugScreen
              ? () {
                  storage.setDebugEnable(true);
                  setState(() => showDebug = true);
                }
              : null,
          onTap: () => navigator().setRoot(AboutRoute.name),
        ),
        _buildDivider(),
        if (showDebug)
          ListTile(
            selected: current == DebugRoute.name,
            leading: AdaptiveSettingsMenuIcon(
              defaultIcon: Icons.perm_device_information,
              iconName: 'debug',
              color: theme.primaryColor,
              background: iconBG,
            ),
            title: Text("Debug"),
            trailing: _buildTrailingArrow(),
            onTap: () => navigator().setRoot(DebugRoute.name),
          ),
        if (showDebug) _buildDivider(),
        if (BuildProperty.deleteAccountLink.isNotEmpty)
          ListTile(
            leading: AdaptiveSettingsMenuIcon(
              defaultIcon: Icons.delete_outline,
              iconName: 'delete-account',
              color: theme.primaryColor,
              background: iconBG,
            ),
            title: Text(S.current.settings_delete_account),
            trailing: _buildTrailingArrow(),
            onTap: () => launchUrl(Uri.parse(BuildProperty.deleteAccountLink)),
          ),
        if (BuildProperty.deleteAccountLink.isNotEmpty) _buildDivider(),
        if (!BuildProperty.multiUserEnable)
          ListTile(
            leading: AdaptiveSettingsMenuIcon(
              defaultIcon: Icons.exit_to_app,
              iconName: 'exit',
              color: theme.primaryColor,
              background: iconBG,
            ),
            title: Text(S.of(context).messages_list_app_bar_logout),
            trailing: _buildTrailingArrow(),
            onTap: _exit,
          ),
      ],
    );
    if (isTablet) {
      body = Scaffold(
        appBar: AMAppBar(
          title: Text(S.of(context).settings),
          shadow: BoxShadow(color: Colors.transparent),
        ),
        body: Column(
          children: [
            if (BuildProperty.useAppBarDivider)
              Container(
                height: 1,
                color: AppColor.appBarDivider,
              ),
            Expanded(
              child: Row(
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
              shadow: BoxShadow(color: Colors.transparent),
            ),
      body: isTablet
          ? body
          : Column(
              children: [
                if (BuildProperty.useAppBarDivider)
                  Container(
                    height: 1,
                    color: AppColor.appBarDivider,
                  ),
                Expanded(child: body),
              ],
            ),
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
