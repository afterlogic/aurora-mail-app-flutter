import 'dart:async';

import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/contact_edit_route.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/contact_view_android.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/contact_view_route.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/components/contacts_app_bar.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/import_key_dialog.dart';
import 'package:aurora_mail/res/str/s.dart';
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
import 'package:theme/app_theme.dart';

import 'components/contacts_drawer.dart';
import 'components/contacts_list_tile.dart';

class ContactsListAndroid extends StatefulWidget {
  @override
  _ContactsListAndroidState createState() => _ContactsListAndroidState();
}

class _ContactsListAndroidState extends BState<ContactsListAndroid> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  ContactsBloc contactsBloc;
  PgpSettingsBloc pgpSettingsBloc;
  Contact selectedContact;
  Widget selectedWidget;

  @override
  void initState() {
    super.initState();
    contactsBloc = BlocProvider.of<ContactsBloc>(context);
    pgpSettingsBloc =
        AppInjector.instance.pgpSettingsBloc(BlocProvider.of(context));
  }

  void _onContactSelected(BuildContext context, Contact contact) {
    final config = LayoutConfig.of(context);
    if (config.isTablet && config.columnCount >= 3) {
      if (selectedContact != contact) {
        selectedContact = contact;
        selectedWidget = SizedBox(
          key: ValueKey(contact.hashCode),
          child: ContactViewAndroid(
            contact,
            Scaffold.of(context),
            pgpSettingsBloc,
            isPart: true,
          ),
        );
        setState(() {});
      }
    } else {
      Navigator.pushNamed(
        context,
        ContactViewRoute.name,
        arguments: ContactViewScreenArgs(
          pgpSettingsBloc,
          contact: contact,
          mailBloc: BlocProvider.of<MailBloc>(context),
          contactsBloc: contactsBloc,
          scaffoldState: Scaffold.of(context),
        ),
      );
    }
  }

  Future<void> _onRefresh() {
    final completer = Completer();
    contactsBloc.add(GetContacts(completer: completer));
    return completer.future;
  }

  void _importKey(Map<PgpKey, bool> userKeys,
      Map<PgpKeyWithContact, bool> contactKeys) async {
    await showDialog(
      context: context,
      builder: (_) => ImportKeyDialog(userKeys, contactKeys, pgpSettingsBloc),
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = LayoutConfig.of(context);
    final isTablet = config.isTablet;
    Widget body = BlocListener(
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
            showErrorSnack(
              context: context,
              scaffoldState: Scaffold.of(context),
              msg: state.error,
            );
          }
        },
        child: RefreshIndicator(
          key: _refreshKey,
          onRefresh: _onRefresh,
          backgroundColor: Colors.white,
          color: Colors.black,
          child: BlocBuilder<ContactsBloc, ContactsState>(
              builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: [
                state.contacts?.isNotEmpty == true
                    ? _buildContacts(context, state)
                    : _buildContactsEmpty(state),
                state.progress ? _buildLoading(state) : SizedBox.shrink(),
              ],
            );
          }),
        ),
      ),
    );
    if (isTablet) {
      body = Scaffold(
        appBar: ContactsAppBar(
          enable: false,
        ),
        body: Row(
          children: [
            ClipRRect(
              child: SizedBox(
                width: 304,
                child: Scaffold(
                  body: DecoratedBox(
                      position: DecorationPosition.foreground,
                      decoration: BoxDecoration(
                          border: Border(right: BorderSide(width: 0.2))),
                      child: ContactsDrawer()),
                ),
              ),
            ),
            Flexible(
              child: ClipRRect(
                child: Scaffold(
                  body: DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(
                        border:
                            selectedWidget == null && config.columnCount >= 3
                                ? null
                                : Border(right: BorderSide(width: 0.2))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: ContactsAppBar(
                            isAppBar: false,
                          ),
                        ),
                        Divider(height: 1),
                        Expanded(child: body),
                      ],
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endFloat,
                  floatingActionButton: AMFloatingActionButton(
                    child: IconTheme(
                      data: AppTheme.floatIconTheme,
                      child: Icon(MdiIcons.accountPlusOutline),
                    ),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      ContactEditRoute.name,
                      arguments: ContactEditScreenArgs(pgpSettingsBloc,
                          bloc: contactsBloc),
                    ),
                  ),
                ),
              ),
            ),
            if (selectedWidget != null && config.columnCount >= 3)
              Flexible(
                child: ClipRRect(child: selectedWidget),
              ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: isTablet ? null : ContactsAppBar(),
      drawer: isTablet ? null : ContactsDrawer(),
      body: body,
      bottomNavigationBar:
          MailBottomAppBar(selectedRoute: MailBottomAppBarRoutes.contacts),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: isTablet
          ? null
          : AMFloatingActionButton(
              child: IconTheme(
                data: AppTheme.floatIconTheme,
                child: Icon(MdiIcons.accountPlusOutline),
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                ContactEditRoute.name,
                arguments:
                    ContactEditScreenArgs(pgpSettingsBloc, bloc: contactsBloc),
              ),
            ),
    );
  }

  void _deleteContact(Contact contact) {
    contactsBloc.add(DeleteContacts([contact]));
  }

  Widget _buildLoading(ContactsState state) {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildContactsEmpty(ContactsState state) {
    return AMEmptyList(message: i18n(context, S.contacts_empty));
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
