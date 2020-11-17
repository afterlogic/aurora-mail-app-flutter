import 'package:aurora_mail/modules/app_config/app_config.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/contacts_list_route.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_main_route.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum MailBottomAppBarRoutes { mail, contacts, settings }

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
        mailBloc: mailBloc,
        contactsBloc: contactsBloc,
      ),
    );
  }

  void _openMail(BuildContext context) {
    Navigator.pushReplacementNamed(context, MessagesListRoute.name);
  }

  void _openSettings(BuildContext context) {
    Navigator.pushReplacementNamed(context, SettingsMainRoute.name);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = AppConfig.of(context).isTablet;
    final iconSize = 28.0;
    Widget row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: Icon(
            MdiIcons.email,
            color: selectedRoute == MailBottomAppBarRoutes.mail
                ? theme.accentColor
                : theme.disabledColor,
          ),
          tooltip: i18n(context, S.messages_list_app_bar_mail),
          iconSize: iconSize,
          onPressed: () => _openMail(context),
        ),
        IconButton(
          icon: Icon(
            MdiIcons.contactMail,
            color: selectedRoute == MailBottomAppBarRoutes.contacts
                ? theme.accentColor
                : theme.disabledColor,
          ),
          tooltip: i18n(context, S.messages_list_app_bar_contacts),
          iconSize: iconSize,
          onPressed: () => _openContacts(context),
        ),
        IconButton(
          icon: Icon(
            MdiIcons.settings,
            color: selectedRoute == MailBottomAppBarRoutes.settings
                ? theme.accentColor
                : theme.disabledColor,
          ),
          tooltip: i18n(context, S.messages_list_app_bar_settings),
          iconSize: iconSize,
          onPressed: () => _openSettings(context),
        ),
      ],
    );
    if (isTablet) {
      row = Row(
        children: [
          Spacer(),
          Flexible(flex: 1, child: row),
          Spacer(),
        ],
      );
    }
    return BottomAppBar(
      child: row,
    );
  }
}
