//@dart=2.9
import 'package:aurora_mail/modules/auth/screens/backup_code_auth/backup_code_auth_widget.dart';
import 'package:aurora_mail/modules/auth/screens/trust_device/trust_device_widget.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/attendees_page.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/calendar_page.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/calendar_route.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_creation_page.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_view_page.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/task_creation_page.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/task_view_page.dart';
import 'package:aurora_mail/modules/calendar/ui/views/tasks_view.dart';
import 'auth/screens/backup_code_auth/backup_code_auth_route.dart';
import 'auth/screens/fido_auth/fido_auth.dart';
import 'auth/screens/fido_auth/fido_auth_route.dart';
import 'package:aurora_mail/modules/auth/screens/select_two_factor/select_two_factor.dart';
import 'package:aurora_mail/modules/auth/screens/select_two_factor/select_two_factor_route.dart';
import 'package:aurora_mail/modules/auth/screens/upgrade_plan/upgrade_plan_route.dart';
import 'package:aurora_mail/modules/auth/screens/upgrade_plan/upgrade_plan_widget.dart';
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
import 'package:aurora_mail/modules/mail/screens/message_view/components/route_with_finish_callback.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_android.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_progress.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_route.dart';
import 'package:aurora_mail/modules/settings/screens/about/about_android.dart';
import 'package:aurora_mail/modules/settings/screens/common_settings/common_settings_android.dart';
import 'package:aurora_mail/modules/settings/screens/common_settings/common_settings_route.dart';
import 'package:aurora_mail/modules/settings/screens/debug/debug_route.dart';
import 'package:aurora_mail/modules/settings/screens/debug/debug_settings.dart';
import 'package:aurora_mail/modules/settings/screens/manage_users/manage_users_android.dart';
import 'package:aurora_mail/modules/settings/screens/manage_users/manage_users_route.dart';
import 'package:aurora_mail/modules/settings/screens/notifications_settings/notifications_settings.dart';
import 'package:aurora_mail/modules/settings/screens/notifications_settings/notifications_settings_route.dart';
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
import 'auth/screens/trust_device/trust_device_route.dart';
import 'auth/screens/two_factor_auth/two_factor_auth_route.dart';
import 'auth/screens/two_factor_auth/two_factor_auth_widget.dart';
import 'mail/blocs/mail_bloc/mail_bloc.dart';
import 'mail/screens/message_view/message_headers.dart';
import 'mail/screens/messages_list/messages_list_android.dart';
import 'mail/screens/messages_list/messages_list_route.dart';
import 'settings/screens/about/about_route.dart';

class RouteGenerator {
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
      case TrustDeviceRoute.name:
        final args = settings.arguments as TrustDeviceRouteArgs;
        return FadeRoute(
          settings: RouteSettings(
            name: settings.name,
          ),
          builder: (_) => TrustDeviceWidget(args: args),
        );

        break;
      case FidoAuthRoute.name:
        final args = settings.arguments as FidoAuthRouteArgs;
        return FadeRoute(
          settings: RouteSettings(
            name: settings.name,
          ),
          builder: (_) => IosFidoAuthWidget(args: args),
        );

        break;
      case SelectTwoFactorRoute.name:
        final args = settings.arguments as SelectTwoFactorRouteArgs;
        return FadeRoute(
          settings: RouteSettings(
            name: settings.name,
          ),
          builder: (_) => SelectTwoFactorWidget(args: args),
        );

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
      case BackupCodeAuthRoute.name:
        final args = settings.arguments as BackupCodeAuthRouteArgs;

        return FadeRoute(
          settings: RouteSettings(
            name: settings.name,
          ),
          builder: (_) => BackupCodeAuthWidget(
            args: args,
          ),
        );

        break;
      case UpgradePlanRoute.name:
        final args = settings.arguments as UpgradePlanArg;
        return FadeRoute(
          settings: RouteSettings(
            name: settings.name,
          ),
          builder: (_) => UpgradePlanWidget(args?.message),
        );

        break;

      // ================= CALENDAR =================

      case CalendarRoute.name:
        final args = settings.arguments as CalendarPageArg;
        return FadeRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => CalendarPage(args: args,));
        break;

      case EventViewPage.name:
        return FadeRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => EventViewPage());
        break;

      case TaskViewPage.name:
        return FadeRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => TaskViewPage());
        break;

      case EventCreationPage.name:
        return FadeRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => EventCreationPage());
        break;
      case TaskCreationPage.name:
        return FadeRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => TaskCreationPage());
        break;

      case AttendeesPage.name:
        final args = settings.arguments as AttendeesRouteArg;
        return FadeRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => AttendeesPage(
            initAttendees: args.initAttendees,
          ),
        );
        break;

      // ================= MAIL =================

      case MessagesListRoute.name:
        final args = settings.arguments as MessagesListRouteArg;
        return FadeRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => MessagesListAndroid(
            initSearch: args?.search,
          ),
        );
        break;
      case MessageHeadersRoute.name:
        final args = settings.arguments as MessageHeadersRouteArg;
        return FadeRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => MessageHeaders(args.text));
        break;
      case MessageViewRoute.name:
        final args = settings.arguments as MessageViewScreenArgs;
        final routeAnimationListener = RouteAnimationListener();
        return RouteWithFinishCallback(
          routeAnimationListener: routeAnimationListener,
          settings: RouteSettings(name: settings.name),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<MailBloc>.value(value: args.mailBloc),
              BlocProvider<MessagesListBloc>.value(
                  value: args.messagesListBloc),
              BlocProvider<ContactsBloc>.value(value: args.contactsBloc),
            ],
            child: MessageViewAndroid(
              args.message,
              routeAnimationListener,
            ),
          ),
        );
        break;
      case MessageProgressRoute.name:
        final args = settings.arguments as MessageProgressRouteArg;
        final routeAnimationListener = RouteAnimationListener();
        return RouteWithFinishCallback(
          routeAnimationListener: routeAnimationListener,
          settings: RouteSettings(name: settings.name),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<MailBloc>.value(value: args.mailBloc),
              BlocProvider<MessagesListBloc>.value(
                  value: args.messagesListBloc),
              BlocProvider<ContactsBloc>.value(value: args.contactsBloc),
            ],
            child: MessageViewProgress(
              args.message,
              routeAnimationListener,
            ),
          ),
        );
        break;

      case ComposeRoute.name:
        final args = settings.arguments as ComposeScreenArgs;
        return MaterialPageRoute(
            settings: RouteSettings(name: settings.name),
            fullscreenDialog: true,
            builder: (_) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<MailBloc>.value(value: args.mailBloc),
                  BlocProvider<ContactsBloc>.value(value: args.contactsBloc),
                ],
                child: ComposeAndroid(
                  args.mailBloc.user,
                  args.mailBloc.account,
                  composeAction: args.composeAction,
                ),
              );
            });
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
                  child: ContactViewAndroid(
                      args.contact, args.scaffoldState, args.pgpSettingBloc),
                ));
        break;

      case ContactEditRoute.name:
        final args = settings.arguments as ContactEditScreenArgs;
        return MaterialPageRoute(
            settings: RouteSettings(name: settings.name),
            fullscreenDialog: true,
            builder: (_) => BlocProvider<ContactsBloc>.value(
                value: args.bloc,
                child: ContactEditAndroid(
                  args.pgpSettingsBloc,
                  contact: args?.contact,
                )));
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
        return CupertinoPageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => BlocProvider<ContactsBloc>.value(
                value: args.bloc, child: GroupEditAndroid(group: args.group)));
        break;

      // ================= SETTINGS =================
      case DebugRoute.name:
        return FadeRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => DebugSetting());
        break;
      case SettingsMainRoute.name:
        return FadeRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => SettingsMainAndroid());
        break;
      case NotificationsSettingsRoute.name:
        return CupertinoPageRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            builder: (_) => NotificationsSettings());
        break;
      case PgpSettingsRoute.name:
        final arg = settings.arguments as PgpSettingsRouteArg;
        return CupertinoPageRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            builder: (_) => PgpSettings(
                  arg.pgpSettingsBloc,
                ));
        break;
      case PgpKeyRoute.name:
        final arg = settings.arguments as PgpKeyRouteArg;
        return CupertinoPageRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            builder: (_) => PgpKeyScreen(
                  arg.pgpKey,
                  arg.onDelete,
                  arg.withAppBar,
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
