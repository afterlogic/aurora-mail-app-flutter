import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/contact_edit_android.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_edit/contact_edit_route.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/contact_view_android.dart';
import 'package:aurora_mail/modules/contacts/screens/contact_view/contact_view_route.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/contacts_list_android.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/contacts_list_route.dart';
import 'package:aurora_mail/modules/contacts/screens/group_edit/group_edit_android.dart';
import 'package:aurora_mail/modules/contacts/screens/group_edit/group_edit_route.dart';
import 'package:aurora_mail/modules/contacts/screens/group_view/group_view_android.dart';
import 'package:aurora_mail/modules/contacts/screens/group_view/group_view_route.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_android.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_android.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_route.dart';
import 'package:aurora_mail/modules/settings/screens/about/about_android.dart';
import 'package:aurora_mail/modules/settings/screens/common_settings/common_settings_android.dart';
import 'package:aurora_mail/modules/settings/screens/common_settings/common_settings_route.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_main_android.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_main_route.dart';
import 'package:aurora_mail/modules/settings/screens/sync_settings/sync_settings_android.dart';
import 'package:aurora_mail/modules/settings/screens/sync_settings/sync_settings_route.dart';
import 'package:aurora_mail/shared_ui/fade_route.dart';
import 'package:aurora_mail/shared_ui/slide_horizontal_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/screens/login/login_android.dart';
import 'auth/screens/login/login_route.dart';
import 'mail/blocs/mail_bloc/mail_bloc.dart';
import 'mail/screens/messages_list/messages_list_android.dart';
import 'mail/screens/messages_list/messages_list_route.dart';
import 'settings/screens/about/about_route.dart';

class AppNavigation {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ================= AUTH =================

      case LoginRoute.name:
        return FadeRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            page: LoginAndroid());

      // ================= MAIL =================

      case MessagesListRoute.name:
        return FadeRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            page: MessagesListAndroid());
        break;

      case MessageViewRoute.name:
        final args = settings.arguments as MessageViewScreenArgs;

        return SlideHorizontalRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            page: MultiBlocProvider(providers: [
              BlocProvider<MailBloc>.value(value: args.mailBloc),
              BlocProvider<MessagesListBloc>.value(value: args.messagesListBloc),
              BlocProvider<ContactsBloc>.value(value: args.contactsBloc),
            ], child: MessageViewAndroid(args.messages, args.initialPage)));
        break;

      case ComposeRoute.name:
        final args = settings.arguments as ComposeScreenArgs;
        return MaterialPageRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            fullscreenDialog: true,
            builder: (_) =>
                MultiBlocProvider(
                  providers: [
                    BlocProvider<MailBloc>.value(value: args.mailBloc),
                    BlocProvider<ContactsBloc>.value(value: args.contactsBloc),
                  ],
                  child: ComposeAndroid(
                    message: args.message,
                    draftUid: args.draftUid,
                    composeType: args.composeType,
                  ),
                ));
        break;

      // ================= CONTACTS =================

      case ContactsListRoute.name:
        final args = settings.arguments as ContactsListScreenArgs;
        return FadeRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            page: BlocProvider<ContactsBloc>.value(
                value: args.bloc, child: ContactsListAndroid()));
        break;

      case ContactViewRoute.name:
        final args = settings.arguments as ContactViewScreenArgs;
        return SlideHorizontalRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            page: BlocProvider<ContactsBloc>.value(
                value: args.bloc, child: ContactViewAndroid(args.contact, args.scaffoldState)));
        break;

      case ContactEditRoute.name:
        final args = settings.arguments as ContactEditScreenArgs;
        return MaterialPageRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            fullscreenDialog: true,
            builder: (_) => BlocProvider<ContactsBloc>.value(
                value: args.bloc, child: ContactEditAndroid(contact: args?.contact)));
        break;

      case GroupViewRoute.name:
        final args = settings.arguments as GroupViewScreenArgs;
        return SlideHorizontalRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            page: BlocProvider<ContactsBloc>.value(
                value: args.bloc, child: GroupViewAndroid(args.group)));
        break;

      case GroupEditRoute.name:
        final args = settings.arguments as GroupEditScreenArgs;
        return MaterialPageRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            fullscreenDialog: true,
            builder: (_) => BlocProvider<ContactsBloc>.value(
                value: args.bloc, child: GroupEditAndroid(group: args.group)));
        break;

      // ================= SETTINGS =================

      case SettingsMainRoute.name:
        return SlideHorizontalRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            page: SettingsMainAndroid());
        break;

      case CommonSettingsRoute.name:
        return SlideHorizontalRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            page: CommonSettingsAndroid());
        break;

      case SyncSettingsRoute.name:
        return SlideHorizontalRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            page: SyncSettingsAndroid());
        break;

      case AboutRoute.name:
        return SlideHorizontalRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            page: AboutAndroid());
        break;

      // ==================================

      default:
        return SlideHorizontalRoute(
            page: Scaffold(
          body: Text('No route defined for ${settings.name}'),
        ));
    }
  }
}
