
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/calendar_route.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/contacts_list_route.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_main_route.dart';
import 'package:aurora_mail/shared_ui/adaptive_bottom_bar_button.dart';
import 'package:aurora_mail/utils/extensions/bloc_provider_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:theme/app_color.dart';

enum MailBottomAppBarRoutes { mail, contacts, settings, calendar }

class MailBottomAppBar extends StatelessWidget {
  final MailBottomAppBarRoutes selectedRoute;

  const MailBottomAppBar({required this.selectedRoute});

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
    final isCalendarExist =
        BlocProviderExtensions.tryOf<CalendarsBloc>(context) != null;

    // Defining colors for icons
    Color activeColor, inactiveColor;
    if (BuildProperty.useCustomBottomBarColors) {
      // We use custom colors depending on the theme.
      final isDarkTheme = theme.brightness == Brightness.dark;
      if (isDarkTheme) {
        activeColor = AppColor.bottomBarIconActiveDark;
        inactiveColor = AppColor.bottomBarIconDark;
      } else {
        activeColor = AppColor.bottomBarIconActiveLight;
        inactiveColor = AppColor.bottomBarIconLight;
      }
    } else {
      // We use standard theme colors.
      activeColor = theme.primaryColor;
      inactiveColor = theme.disabledColor;
    }

    // We determine the margins depending on whether the captions are displayed.
    final padding = BuildProperty.showBottomBarLabels
        ? EdgeInsets.symmetric(horizontal: 0, vertical: 8)
        : EdgeInsets.symmetric(horizontal: 0, vertical: 6);

    Widget row = Container(
        color: theme.bottomNavigationBarTheme.backgroundColor,
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: AdaptiveBottomBarButton(
                mdiIcon: MdiIcons.email,
                iconName: 'mail',
                label: S.of(context).messages_list_app_bar_mail,
                isActive: selectedRoute == MailBottomAppBarRoutes.mail,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onPressed: () => _openMail(context),
                iconSize: iconSize,
              ),
            ),
            Expanded(
              child: AdaptiveBottomBarButton(
                mdiIcon: MdiIcons.cardAccountMail,
                iconName: 'contacts',
                label: S.of(context).messages_list_app_bar_contacts,
                isActive: selectedRoute == MailBottomAppBarRoutes.contacts,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onPressed: () => _openContacts(context),
                iconSize: iconSize,
              ),
            ),
            if (isCalendarExist)
              Expanded(
                child: AdaptiveBottomBarButton(
                  mdiIcon: MdiIcons.calendar,
                  iconName: 'calendar',
                  label: S.of(context).calendar,
                  isActive: selectedRoute == MailBottomAppBarRoutes.calendar,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  onPressed: () => _openCalendar(context),
                  iconSize: iconSize,
                ),
              ),
            Expanded(
              child: AdaptiveBottomBarButton(
                mdiIcon: MdiIcons.cog,
                iconName: 'settings',
                label: S.of(context).messages_list_app_bar_settings,
                isActive: selectedRoute == MailBottomAppBarRoutes.settings,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onPressed: () => _openSettings(context),
                iconSize: iconSize,
              ),
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
      child: SafeArea(
        child: row,
      ),
    );
  }
}
