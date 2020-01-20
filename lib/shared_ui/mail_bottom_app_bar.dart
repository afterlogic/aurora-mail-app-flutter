import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/contacts_list_route.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_main_route.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MailBottomAppBarRoutes { mail, contacts }

class MailBottomAppBar extends StatelessWidget {
  final MailBottomAppBarRoutes selectedRoute;

  const MailBottomAppBar({@required this.selectedRoute});

  void _openContacts(BuildContext context) {
    final mailBloc = BlocProvider.of<MailBloc>(context);
    final contactsBloc = BlocProvider.of<ContactsBloc>(context);

    Navigator.pushReplacementNamed(
      context,
      ContactsListRoute.name,
      arguments: ContactsListScreenArgs(
          mailBloc: mailBloc, contactsBloc: contactsBloc),
    );
  }

  void _openMail(BuildContext context) {
    Navigator.pushReplacementNamed(context, MessagesListRoute.name);
  }

  void _openSettings(BuildContext context) {
    Navigator.pushNamed(context, SettingsMainRoute.name);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        children: <Widget>[
          SizedBox(width: 12.0),
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: i18n(context, "messages_list_app_bar_settings"),
            onPressed: () => _openSettings(context),
          ),
          IconButton(
            icon: Icon(
              selectedRoute == MailBottomAppBarRoutes.mail
                  ? Icons.mail
                  : Icons.mail_outline,
              color: selectedRoute == MailBottomAppBarRoutes.mail
                  ? Theme.of(context).accentColor
                  : null,
            ),
            tooltip: i18n(context, "messages_list_app_bar_mail"),
            onPressed: () => _openMail(context),
          ),
          IconButton(
            icon: Icon(
              selectedRoute == MailBottomAppBarRoutes.contacts
                  ? Icons.people
                  : Icons.people_outline,
              color: selectedRoute == MailBottomAppBarRoutes.contacts
                  ? Theme.of(context).accentColor
                  : null,
            ),
            tooltip: i18n(context, "messages_list_app_bar_contacts"),
            onPressed: () => _openContacts(context),
          ),
        ],
      ),
    );
  }
}
