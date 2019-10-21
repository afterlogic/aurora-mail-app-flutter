import 'dart:io';

import 'package:aurora_mail/shared_ui/fade_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'auth/auth_android.dart';
import 'auth/auth_route.dart';
import 'mail/mail_android.dart';
import 'mail/mail_route.dart';

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

      case MailRoute.name:
        if (Platform.isIOS) {
          return CupertinoPageRoute(
              settings: RouteSettings(
                name: settings.name,
              ),
              builder: (context) => MailAndroid());
        } else {
          return FadeRoute(
              settings: RouteSettings(
                name: settings.name,
              ),
              page: MailAndroid());
        }
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
