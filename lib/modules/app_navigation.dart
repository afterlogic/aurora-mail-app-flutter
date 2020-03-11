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
import 'package:aurora_mail/modules/settings/screens/manage_users/manage_users_android.dart';
import 'package:aurora_mail/modules/settings/screens/manage_users/manage_users_route.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/pgp_settings.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/pgp_settings_route.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/screens/pgp_key.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/screens/pgp_key_route.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/screens/pgp_keys.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/screens/pgp_keys_route.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_main_android.dart';
import 'package:aurora_mail/modules/settings/screens/settings_main/settings_main_route.dart';
import 'package:aurora_mail/modules/settings/screens/sync_settings/sync_settings_android.dart';
import 'package:aurora_mail/modules/settings/screens/sync_settings/sync_settings_route.dart';
import 'package:aurora_mail/shared_ui/fade_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/screens/login/login_android.dart';
import 'auth/screens/login/login_route.dart';
import 'auth/screens/two_factor_auth/two_factor_auth_route.dart';
import 'auth/screens/two_factor_auth/two_factor_auth_widget.dart';
import 'mail/blocs/mail_bloc/mail_bloc.dart';
import 'mail/screens/messages_list/messages_list_android.dart';
import 'mail/screens/messages_list/messages_list_route.dart';
import 'settings/screens/about/about_route.dart';

class AppNavigation {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ================= AUTH =================

      case LoginRoute.name:
        final args = settings.arguments as LoginRouteScreenArgs;

        if (args != null && args.isDialog == true) {
          return CupertinoPageRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            fullscreenDialog: true,
            builder: (_) =>
                LoginAndroid(isDialog: args.isDialog, email: args.email),
          );
        } else {
          return FadeRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            builder: (_) => LoginAndroid(),
          );
        }
        break;
      case TwoFactorAuthRoute.name:
        final args = settings.arguments as TwoFactorAuthRouteArgs;

        return FadeRoute(
          settings: RouteSettings(
            name: settings.name,
          ),
          builder: (_) => TwoFactorAuthWidget(
            args: args,
          ),
        );

        break;

      // ================= MAIL =================

      case MessagesListRoute.name:
        final args = settings.arguments as MessagesListRouteArg;
        return FadeRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => MessagesListAndroid(initSearch: args?.search));
        break;

      case MessageViewRoute.name:
        final args = settings.arguments as MessageViewScreenArgs;

        return CupertinoPageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider<MailBloc>.value(value: args.mailBloc),
                  BlocProvider<MessagesListBloc>.value(
                      value: args.messagesListBloc),
                  BlocProvider<ContactsBloc>.value(value: args.contactsBloc),
                ], child: MessageViewAndroid(args.message)));
        break;

      case ComposeRoute.name:
        final args = settings.arguments as ComposeScreenArgs;
        return MaterialPageRoute(
            settings: RouteSettings(name: settings.name),
            fullscreenDialog: true,
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<MailBloc>.value(value: args.mailBloc),
                    BlocProvider<ContactsBloc>.value(value: args.contactsBloc),
                  ],
                  child: ComposeAndroid(composeAction: args.composeAction),
                ));
        break;

      // ================= CONTACTS =================

      case ContactsListRoute.name:
        final args = settings.arguments as ContactsListScreenArgs;
        return FadeRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<MailBloc>.value(value: args.mailBloc),
                    BlocProvider<ContactsBloc>.value(value: args.contactsBloc),
                  ],
                  child: ContactsListAndroid(),
                ));
        break;

      case ContactViewRoute.name:
        final args = settings.arguments as ContactViewScreenArgs;
        return CupertinoPageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<MailBloc>.value(value: args.mailBloc),
                    BlocProvider<ContactsBloc>.value(value: args.contactsBloc),
                  ],
                  child: ContactViewAndroid(args.contact, args.scaffoldState),
                ));
        break;

      case ContactEditRoute.name:
        final args = settings.arguments as ContactEditScreenArgs;
        return MaterialPageRoute(
            settings: RouteSettings(name: settings.name),
            fullscreenDialog: true,
            builder: (_) => BlocProvider<ContactsBloc>.value(
                value: args.bloc,
                child: ContactEditAndroid(contact: args?.contact)));
        break;

      case GroupViewRoute.name:
        final args = settings.arguments as GroupViewScreenArgs;
        return CupertinoPageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => BlocProvider<ContactsBloc>.value(
                value: args.bloc, child: GroupViewAndroid(args.group)));
        break;

      case GroupEditRoute.name:
        final args = settings.arguments as GroupEditScreenArgs;
        return MaterialPageRoute(
            settings: RouteSettings(name: settings.name),
            fullscreenDialog: true,
            builder: (_) => BlocProvider<ContactsBloc>.value(
                value: args.bloc, child: GroupEditAndroid(group: args.group)));
        break;

      // ================= SETTINGS =================

      case SettingsMainRoute.name:
        return FadeRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => SettingsMainAndroid());
        break;

      case PgpSettingsRoute.name:
        return CupertinoPageRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            builder: (_) => PgpSettings());
        break;
      case PgpKeyRoute.name:
        final arg = settings.arguments as PgpKeyRouteArg;
        return CupertinoPageRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            builder: (_) => PgpKeyScreen(
                  arg.pgpKey,
                  arg.bloc,
                ));
        break;
      case PgpKeysRoute.name:
        final arg = settings.arguments as PgpKeysRouteArg;
        return CupertinoPageRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            builder: (_) => PgpKeysScreen(
                  arg.pgpKeys,
                  arg.bloc,
                ));
        break;
      case CommonSettingsRoute.name:
        return CupertinoPageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => CommonSettingsAndroid());
        break;

      case SyncSettingsRoute.name:
        return CupertinoPageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => SyncSettingsAndroid());
        break;

      case ManageUsersRoute.name:
        return CupertinoPageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => ManageUsersAndroid());
        break;

      case AboutRoute.name:
        return CupertinoPageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => AboutAndroid());
        break;

      // ==================================

      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Text('No route defined for ${settings.name}'),
                ));
    }
  }
}
