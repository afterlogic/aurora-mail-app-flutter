import 'package:aurora_mail/modules/mail/screens/message_view/message_view_android.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_route.dart';
import 'package:aurora_mail/shared_ui/fade_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'auth/auth_android.dart';
import 'auth/auth_route.dart';
import 'mail/screens/messages_list/messages_list_android.dart';
import 'mail/screens/messages_list/messages_list_route.dart';

class AppNavigation {
  static String currentRoute = "/";

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
            builder: (context) => MessageViewAndroid(args.messages, args.initialPage));
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
