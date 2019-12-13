import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/i18n.dart';
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
import 'components/contacts_list_tile.dart';

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

  @override
  void dispose() {
    _contactsBloc.close();
    super.dispose();
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
        appBar: ContactsAppBar(onActionSelected: _onAppBarActionSelected),
        drawer: ContactsDrawer(),
        body: BlocListener<ContactsBloc, ContactsState>(
          listener: (context, state) {
            if (state.error != null) {
              showSnack(
                  context: context,
                  scaffoldState: Scaffold.of(context),
                  msg: state.error);
            }
          },
          child: BlocBuilder<ContactsBloc, ContactsState>(
              builder: (_, state) {
                if (state.contacts == null)
                  return _buildLoading(state);
                else if (state.contacts.isEmpty)
                  return _buildContactsEmpty(state);
                else
                  return _buildContacts(state);
              }
          ),
        ),
      ),
    );
  }

  Widget _buildLoading(ContactsState state) {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildContactsEmpty(ContactsState state) {
    return Center(child: Text(S.of(context).contacts_empty));
  }

  Widget _buildContacts(ContactsState state) {
    return ListView.separated(
      itemBuilder: (_, i) => ContactsListTile(state.contacts[i]),
      separatorBuilder: (_, i) => Divider(indent: 16.0, endIndent: 16.0),
      itemCount: state.contacts.length,
    );
  }


}
