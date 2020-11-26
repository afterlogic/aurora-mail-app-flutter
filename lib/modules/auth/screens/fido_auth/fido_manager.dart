import 'dart:io';

import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/screens/fido_auth/platform/android/android_fido_auth_route.dart';
import 'package:aurora_mail/modules/auth/screens/fido_auth/platform/ios/ios_fido_auth.dart';
import 'package:aurora_mail/modules/auth/screens/fido_auth/platform/ios/ios_fido_auth_route.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/cupertino.dart';

Future fidoManager(
  BuildContext context,
  bool isDialog,
  String host,
  String login,
  String password,
  TwoFactor state,
  AuthBloc authBloc,
) {
  Future _androidFido() {
    return Navigator.pushNamed(context, AndroidFidoAuthRoute.name);
  }

  Future _iosFido() {
    return Navigator.pushNamed(
      context,
      IosFidoAuthRoute.name,
      arguments: IosFidoAuthRouteArgs(
        isDialog,
        authBloc,
          state,
      ),
    );
  }

  if (Platform.isIOS) {
    return _iosFido();
  } else {
    return _androidFido();
  }
}
