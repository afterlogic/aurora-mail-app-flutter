import 'dart:async';

import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/main.dart' as main;
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/contact_view_route.dart';
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

  StreamSubscription _contactsSync;

  @override
  void initState() {
    super.initState();
    _contactsSync = main.alarmStream.listen((_) {
      BlocProvider.of<ContactsBloc>(context).add(GetContacts());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _contactsSync.cancel();
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

  void _onContactSelected(Contact contact) {
    Navigator.pushNamed(context, ContactViewRoute.name,
        arguments: ContactViewScreenArgs(contact, BlocProvider.of<ContactsBloc>(context)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: RefreshIndicator(
          onRefresh: () async =>
              BlocProvider.of<ContactsBloc>(context).add(GetContacts()),
          child: BlocBuilder<ContactsBloc, ContactsState>(
              builder: (_, state) {
                if (state.contacts == null || state.contacts.isEmpty && state.currentlySyncingStorages.contains(state.selectedStorage))
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
    return Column(
      children: <Widget>[
        AnimatedOpacity(
          duration: Duration(milliseconds: 200),
          opacity: state.currentlySyncingStorages != null &&
              state.currentlySyncingStorages.contains(state.selectedStorage)
              ? 1.0
              : 0.0,
          child: SizedBox(
            height: 5.0,
            child: LinearProgressIndicator(),
          ),
        ),
        Flexible(
          child: ListView.separated(
            itemBuilder: (_, i) =>
                ContactsListTile(
                  contact: state.contacts[i],
                  onPressed: _onContactSelected,
                ),
            separatorBuilder: (_, i) => Divider(indent: 16.0, endIndent: 16.0, height: 0.0),
            itemCount: state.contacts.length,
          ),
        ),
      ],
    );
  }


}
