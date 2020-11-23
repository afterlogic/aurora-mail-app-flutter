import 'dart:io';

import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/screens/fido_auth/platform/android/android_fido_auth_route.dart';
import 'package:aurora_mail/modules/auth/screens/fido_auth/platform/ios/ios_fido_auth.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/cupertino.dart';

Future fidoManager(
  BuildContext context,
  bool isDialog,
  String host,
  String login,
  String password,
  AuthBloc authBloc,
) {
  Future _androidFido() {
    return Navigator.pushNamed(context, AndroidFidoAuthRoute.name);
  }

  Future _iosFido() {
    return AMDialog.show(
      context: context,
      builder: (BuildContext context) => IosFidoAuth(
        host,
        login,
        password,
        authBloc,
      ),
    );
  }

  if (Platform.isIOS) {
    return _iosFido();
  } else {
    return _androidFido();
  }
}
