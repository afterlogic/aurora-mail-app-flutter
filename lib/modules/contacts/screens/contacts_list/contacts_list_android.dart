import 'dart:async';

import 'package:aurora_mail/main.dart' as main;
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/contact_edit_route.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/contact_view_route.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/components/contacts_app_bar.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/components/speed_dial.dart';
import 'package:aurora_mail/modules/contacts/screens/group_edit/group_edit_route.dart';
import 'package:aurora_mail/modules/contacts/screens/group_view/group_view_route.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_main_route.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:empty_list/empty_list.dart';
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
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  var _refreshCompleter = new Completer();
  StreamSubscription _contactsSync;

  @override
  void initState() {
    super.initState();
    _contactsSync = main.alarmStream.listen((_) => _refreshKey.currentState.show());
  }

  @override
  void dispose() {
    super.dispose();
    _contactsSync.cancel();
  }

  void _onAppBarActionSelected(ContactsListAppBarAction item, {ContactsGroup group}) {
    switch (item) {
      case ContactsListAppBarAction.viewGroup:
        assert(group != null);
        final bloc = BlocProvider.of<ContactsBloc>(context);
        Navigator.pushNamed(context, GroupViewRoute.name, arguments: GroupViewScreenArgs(group, bloc));
        break;
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

  void _onContactSelected(BuildContext context, Contact contact) {
    Navigator.pushNamed(
      context,
      ContactViewRoute.name,
      arguments: ContactViewScreenArgs(
        contact,
        BlocProvider.of<ContactsBloc>(context),
        Scaffold.of(context),
      ),
    );
  }

  void _onFabOptionSelected(ContactsFabOption option) {
    switch (option) {
      case ContactsFabOption.addContact:
        Navigator.pushNamed(
          context,
          ContactEditRoute.name,
          arguments: ContactEditScreenArgs(
              bloc: BlocProvider.of<ContactsBloc>(context)),
        );
        break;
      case ContactsFabOption.addGroup:
        Navigator.pushNamed(
          context,
          GroupEditRoute.name,
          arguments: GroupEditScreenArgs(bloc: BlocProvider.of<ContactsBloc>(context)),
        );
        break;
    }
  }

  void _completeRefresh() {
    _refreshCompleter?.complete();
    _refreshCompleter = new Completer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContactsAppBar(onActionSelected: _onAppBarActionSelected),
      drawer: ContactsDrawer(),
      body: BlocListener<ContactsBloc, ContactsState>(
        listener: (context, state) {
          if (state.error != null) {
            _completeRefresh();
            showSnack(
              context: context,
              scaffoldState: Scaffold.of(context),
              msg: state.error,
            );
          }

          if (state.currentlySyncingStorages != null) {
            if (state.showAllVisibleContacts == true) {
              if (state.currentlySyncingStorages.isEmpty) {
                // for "All" storage
                _completeRefresh();
              }
            } else {
              if (state.selectedGroup != null) {
                if (state.currentlySyncingStorages.isEmpty) {
                  // for groups
                  _completeRefresh();
                }
              } else if (state.showAllVisibleContacts != true && !state.currentlySyncingStorages.contains(state.selectedStorage)) {
                // for storages
                _completeRefresh();
              }
            }
          }
        },
        child: RefreshIndicator(
          key: _refreshKey,
          onRefresh: () {
            BlocProvider.of<ContactsBloc>(context).add(GetContacts());
            return _refreshCompleter.future;
          },
          backgroundColor: Colors.white,
          color: Colors.black,
          child: BlocBuilder<ContactsBloc, ContactsState>(builder: (context, state) {
            if (state.contacts == null || state.contacts.isEmpty && state.currentlySyncingStorages.contains(state.selectedStorage)) return _buildLoading(state);
            else if (state.contacts.isEmpty) return _buildContactsEmpty(state);
            else return _buildContacts(context, state);
          }),
        ),
      ),
      floatingActionButton: ContactsSpeedDial(_onFabOptionSelected),
    );
  }

  void _deleteContact(Contact contact) {
    BlocProvider.of<ContactsBloc>(context).add(DeleteContacts([contact]));
  }

  Widget _buildLoading(ContactsState state) {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildContactsEmpty(ContactsState state) {
    return EmptyList(message: i18n(context, "contacts_empty"));
  }

  Widget _buildContacts(BuildContext context, ContactsState state) {
    return Column(
      children: <Widget>[
        Flexible(
          child: ListView.separated(
            padding: EdgeInsets.only(bottom: 62.0),
            itemBuilder: (_, i) => ContactsListTile(
              contact: state.contacts[i],
              onPressed: (c) => _onContactSelected(context, c),
              onDeleteContact: _deleteContact,
            ),
            separatorBuilder: (_, i) =>
                Divider(indent: 16.0, endIndent: 16.0, height: 0.0),
            itemCount: state.contacts.length,
          ),
        ),
      ],
    );
  }
}
