import 'package:aurora_mail/modules/mail/screens/compose/compose_android.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_android.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_route.dart';
import 'package:aurora_mail/shared_ui/fade_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/auth_android.dart';
import 'auth/auth_route.dart';
import 'mail/blocs/mail_bloc/mail_bloc.dart';
import 'mail/screens/messages_list/messages_list_android.dart';
import 'mail/screens/messages_list/messages_list_route.dart';

class AppNavigation {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AuthRoute.name:
        return MaterialPageRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            builder: (context) => AuthAndroid());

      case MessagesListRoute.name:
        return FadeRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            page: MessagesListAndroid());
        break;

      case MessageViewRoute.name:
        final MessageViewScreenArgs args = settings.arguments;

        return MaterialPageRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            builder: (_) => BlocProvider<MailBloc>.value(
                value: args.bloc,
                child: MessageViewAndroid(args.messages, args.initialPage)));

        break;

      case ComposeRoute.name:
        final ComposeScreenArgs args = settings.arguments;
        return MaterialPageRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            fullscreenDialog: true,
            builder: (_) => BlocProvider<MailBloc>.value(
                value: args.bloc,
                child: ComposeAndroid()));
        break;

      default:
        return MaterialPageRoute(
            settings: RouteSettings(
              name: settings.name,
            ),
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
