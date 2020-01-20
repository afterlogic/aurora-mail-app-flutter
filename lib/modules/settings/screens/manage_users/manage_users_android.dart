import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_event.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_state.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:empty_list/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'componenets/account_tile.dart';

class ManageUsersAndroid extends StatefulWidget {
  @override
  _ManageUsersAndroidState createState() => _ManageUsersAndroidState();
}

class _ManageUsersAndroidState extends State<ManageUsersAndroid> {
  void _addAccount(BuildContext context) {
    Navigator.pushNamed(context, LoginRoute.name, arguments: LoginRouteScreenArgs(isDialog: true));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<AuthBloc>(context).add(GetUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n(context, "settings_accounts_manage")),
        actions: <Widget>[
          IconButton(
            icon: Icon(MdiIcons.accountPlus),
            tooltip: i18n(context, "settings_accounts_add"),
            onPressed: () => _addAccount(context),
          )
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        condition: (_, state) => state is ReceivedUsers,
        builder: (_, state) {
          if (state is ReceivedUsers) return _buildUsers(context, state);
          else return EmptyList(message: "Error");
        }
      ),
    );
  }

  Widget _buildUsers(BuildContext context, ReceivedUsers state) {
    return ListView.separated(
      itemBuilder: (_, i) {
        final user = state.users[i];
        return AccountTile(user: user);
      },
      separatorBuilder: (_, i) => Divider(height: 0, indent: 16.0),
      itemCount: state.users.length,
    );
  }
}
