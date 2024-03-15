import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_state.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_navigator.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:theme/app_theme.dart';

import 'componenets/account_tile.dart';

class ManageUsersAndroid extends StatefulWidget {
  @override
  _ManageUsersAndroidState createState() => _ManageUsersAndroidState();
}

class _ManageUsersAndroidState extends BState<ManageUsersAndroid> {
  void _addAccount(BuildContext context) {
    SettingsNavigatorWidget.of(context).pushNamed(LoginRoute.name,
        arguments: LoginRouteScreenArgs(isDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = LayoutConfig.of(context).isTablet;
    return Scaffold(
      appBar: isTablet
          ? null
          : AMAppBar(
              title: Text(S.of(context).settings_accounts_manage),
              actions: <Widget>[
                IconButton(
                  icon: Icon(MdiIcons.accountPlus),
                  tooltip: S.of(context).settings_accounts_add,
                  onPressed: () => _addAccount(context),
                )
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: isTablet
          ? AMFloatingActionButton(
              tooltip: S.of(context).settings_accounts_add,
              child: IconTheme(
                data: AppTheme.floatIconTheme,
                child: Icon(MdiIcons.accountPlus),
              ),
              onPressed: () => _addAccount(context),
            )
          : null,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (_, state) => _buildUsers(
          context,
          BlocProvider.of<AuthBloc>(context).users,
        ),
      ),
    );
  }

  Widget _buildUsers(BuildContext context, List<User> users) {
    return ListView.separated(
      itemBuilder: (_, i) {
        final user = users[i];
        return UserTile(user: user);
      },
      separatorBuilder: (_, i) => Divider(height: 0, indent: 16.0),
      itemCount: users.length,
    );
  }
}
