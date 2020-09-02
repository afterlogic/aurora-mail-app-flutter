import 'dart:async';

import 'package:aurora_mail/background/background_helper.dart';
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/contact_edit_route.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/contact_view_route.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/components/contacts_app_bar.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/import_key_dialog.dart';
import 'package:aurora_mail/shared_ui/mail_bottom_app_bar.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:crypto_model/crypto_model.dart';
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

class _ContactsListAndroidState extends BState<ContactsListAndroid> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  PgpSettingsBloc pgpSettingsBloc;

  var _refreshCompleter = new Completer();

  @override
  void initState() {
    super.initState();
    pgpSettingsBloc =
        AppInjector.instance.pgpSettingsBloc(BlocProvider.of(context));
  }



  void _onContactSelected(BuildContext context, Contact contact) {
    Navigator.pushNamed(
      context,
      ContactViewRoute.name,
      arguments: ContactViewScreenArgs(
        pgpSettingsBloc,
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

  _importKey(Map<PgpKey, bool> userKeys,
      Map<PgpKeyWithContact, bool> contactKeys) async {
    await showDialog(
      context: context,
      builder: (_) => ImportKeyDialog(userKeys, contactKeys, pgpSettingsBloc),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContactsAppBar(),
      drawer: ContactsDrawer(),
      body: BlocListener(
        bloc: pgpSettingsBloc,
        listener: (BuildContext context, state) {
          if (state is SelectKeyForImport) {
            _importKey(state.userKeys, state.contactKeys);
            return;
          }
        },
        child: BlocListener<ContactsBloc, ContactsState>(
          listener: (context, state) {
            if (state.key != null) {
              pgpSettingsBloc.add(ParseKey(state.key));
              return;
            }
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
                } else if (state.showAllVisibleContacts != true &&
                    !state.currentlySyncingStorages
                        .contains(state.selectedStorage)) {
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
              if (state.contacts == null ||
                  state.contacts.isEmpty &&
                      state.currentlySyncingStorages
                          .contains(state.selectedStorage))
                return _buildLoading(state);
              else if (state.contacts.isEmpty)
                return _buildContactsEmpty(state);
              else
                return _buildContacts(context, state);
            }),
          ),
        ),
      ),
      bottomNavigationBar:
          MailBottomAppBar(selectedRoute: MailBottomAppBarRoutes.contacts),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AMFloatingActionButton(
        child: Icon(
          MdiIcons.accountPlusOutline,
        ),
        onPressed: () => Navigator.pushNamed(
          context,
          ContactEditRoute.name,
          arguments: ContactEditScreenArgs(pgpSettingsBloc,
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
    return AMEmptyList(message: i18n(context, "contacts_empty"));
  }

  Widget _buildContacts(BuildContext context, ContactsState state) {
    return Column(
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            key: ObjectKey(state.contacts[0]),
            padding: EdgeInsets.only(
                bottom: 82.0 + MediaQuery.of(context).padding.bottom),
            itemBuilder: (_, i) => ContactsListTile(
              contact: state.contacts[i],
              onPressed: (c) => _onContactSelected(context, c),
              onDeleteContact: _deleteContact,
            ),
            itemCount: state.contacts.length,
          ),
        ),
      ],
    );
  }
}
