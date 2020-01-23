import 'dart:async';

import 'package:aurora_mail/main.dart' as main;
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/contact_edit_route.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/contact_view_route.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/components/contacts_app_bar.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_bloc.dart';
import 'package:aurora_mail/shared_ui/mail_bottom_app_bar.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:empty_list/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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

  void _onContactSelected(BuildContext context, Contact contact) {
    Navigator.pushNamed(
      context,
      ContactViewRoute.name,
      arguments: ContactViewScreenArgs(
        contact: contact,
        mailBloc: BlocProvider.of<MailBloc>(context),
        contactsBloc: BlocProvider.of<ContactsBloc>(context),
        scaffoldState: Scaffold.of(context),
      ),
    );
  }

  void _completeRefresh() {
    _refreshCompleter?.complete();
    _refreshCompleter = new Completer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContactsAppBar(),
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
          child: BlocBuilder<ContactsBloc, ContactsState>(
              builder: (context, state) {
                print("VO: state: ${state}");
            if (state.contacts == null || state.contacts.isEmpty && state.currentlySyncingStorages.contains(state.selectedStorage)) return _buildLoading(state);
            else if (state.contacts.isEmpty) return _buildContactsEmpty(state);
            else return _buildContacts(context, state);
          }),
        ),
      ),
      bottomNavigationBar: MailBottomAppBar(
          selectedRoute: MailBottomAppBarRoutes.contacts),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.accountPlusOutline),
        onPressed: () =>
            Navigator.pushNamed(
              context,
              ContactEditRoute.name,
              arguments: ContactEditScreenArgs(
                  bloc: BlocProvider.of<ContactsBloc>(context)),
            ),
      ),
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
            padding: EdgeInsets.only(bottom: 62.0 + MediaQuery.of(context).padding.bottom),
            itemBuilder: (_, i) => ContactsListTile(
              contact: state.contacts[i],
              onPressed: (c) => _onContactSelected(context, c),
              onDeleteContact: _deleteContact,
            ),
            separatorBuilder: (_, i) => Divider(indent: 16.0, endIndent: 16.0, height: 0.0),
            itemCount: state.contacts.length,
          ),
        ),
      ],
    );
  }
}
