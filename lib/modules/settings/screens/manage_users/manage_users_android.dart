import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_event.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_state.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'componenets/account_tile.dart';

class ManageUsersAndroid extends StatefulWidget {
  @override
  _ManageUsersAndroidState createState() => _ManageUsersAndroidState();
}

class _ManageUsersAndroidState extends BState<ManageUsersAndroid> {
  void _addAccount(BuildContext context) {
    Navigator.pushNamed(context, LoginRoute.name,
        arguments: LoginRouteScreenArgs(isDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text(i18n(context, "settings_accounts_manage")),
        actions: <Widget>[
          IconButton(
            icon: Icon(MdiIcons.accountPlus),
            tooltip: i18n(context, "settings_accounts_add"),
            onPressed: () => _addAccount(context),
          )
        ],
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (_, state) =>
              _buildUsers(context, (state as SettingsLoaded))),
    );
  }

  Widget _buildUsers(BuildContext context, SettingsLoaded state) {
    return ListView.separated(
      itemBuilder: (_, i) {
        final user = state.users[i];
        return UserTile(user: user);
      },
      separatorBuilder: (_, i) => Divider(height: 0, indent: 16.0),
      itemCount: state.users.length,
    );
  }
}
