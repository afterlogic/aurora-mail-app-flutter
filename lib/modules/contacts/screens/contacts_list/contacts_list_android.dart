import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/components/contacts_app_bar.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_main_route.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/contacts_drawer.dart';

class ContactsListAndroid extends StatefulWidget {
  @override
  _ContactsListAndroidState createState() => _ContactsListAndroidState();
}

class _ContactsListAndroidState extends State<ContactsListAndroid> {

  ContactsBloc _contactsBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TODO replace static props
    _contactsBloc = new ContactsBloc(
      apiUrl: AuthBloc.apiUrl,
      token: AuthBloc.currentUser.token,
      userId: AuthBloc.currentUser.serverId,
      appDatabase: DBInstances.appDB,
    );

    _contactsBloc.add(GetContacts());
  }

  void _onAppBarActionSelected(ContactsListAppBarAction item) {
    switch (item) {
      case ContactsListAppBarAction.logout:
        BlocProvider.of<AuthBloc>(context).add(LogOut());
        Navigator.pushReplacementNamed(context, LoginRoute.name);
        break;
      case ContactsListAppBarAction.settings:
        Navigator.pushNamed(context, SettingsMainRoute.name);
        break;
      case ContactsListAppBarAction.mail:
        Navigator.pushReplacementNamed(context, MessagesListRoute.name);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _contactsBloc,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(APP_BAR_HEIGHT_ANDROID),
          child: ContactsAppBar(onActionSelected: _onAppBarActionSelected),
        ),
        drawer: ContactsDrawer(),
        body: BlocListener<ContactsBloc, ContactsState>(
          listener: (context, state) {
            if (state.error.isNotEmpty) {
              showSnack(context: context,
                  scaffoldState: Scaffold.of(context),
                  msg: state.error);
            }
          },
          child: ListView.separated(
            itemBuilder: (_, i) => ListTile(),
            separatorBuilder: (_, i) => Divider(),
            itemCount: 0,
          ),
        ),
      ),
    );
  }
}
