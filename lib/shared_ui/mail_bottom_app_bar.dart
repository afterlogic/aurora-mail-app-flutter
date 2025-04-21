//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/calendar_route.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/contacts_list_route.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_main_route.dart';
import 'package:aurora_mail/utils/extensions/bloc_provider_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum MailBottomAppBarRoutes { mail, contacts, settings, calendar }

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

  void _openCalendar(BuildContext context) {
    Navigator.pushReplacementNamed(context, CalendarRoute.name);
  }

  void _openSettings(BuildContext context) {
    Navigator.pushReplacementNamed(context, SettingsMainRoute.name);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = LayoutConfig.of(context).isTablet;
    final iconSize = 28.0;
    final isCalendarExist = BlocProviderExtensions.tryOf<CalendarsBloc>(context) != null;
    Widget row = Container(
      color: Color(0xFFF4F1FD),
      // padding: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal:0, vertical: 6),
      child:
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        
        IconButton(
          icon: Icon(
            MdiIcons.email,
            color: selectedRoute == MailBottomAppBarRoutes.mail
                ? theme.primaryColor
                : theme.disabledColor,
          ),
          tooltip: S.of(context).messages_list_app_bar_mail,
          iconSize: iconSize,
          onPressed: () => _openMail(context),
        ),
        IconButton(
          icon: Icon(
            MdiIcons.cardAccountMail,
            color: selectedRoute == MailBottomAppBarRoutes.contacts
                ? theme.primaryColor
                : theme.disabledColor,
          ),
          tooltip: S.of(context).messages_list_app_bar_contacts,
          iconSize: iconSize,
          onPressed: () => _openContacts(context),
        ),
        if(isCalendarExist)IconButton(
          icon: Icon(
            MdiIcons.calendar,
            color: selectedRoute == MailBottomAppBarRoutes.calendar
                ? theme.primaryColor
                : theme.disabledColor,
          ),
          tooltip: '',
          iconSize: iconSize,
          onPressed: () {
            _openCalendar(context);
          },
        ),
        IconButton(
          icon: Icon(
            MdiIcons.cog,
            color: selectedRoute == MailBottomAppBarRoutes.settings
                ? theme.primaryColor
                : theme.disabledColor,
          ),
          tooltip: S.of(context).messages_list_app_bar_settings,
          iconSize: iconSize,
          onPressed: () => _openSettings(context),
        ),
      ],
    ));
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
