import 'package:flutter/foundation.dart';

class LoginRoute {
  static const name = "login";
}

class LoginRouteScreenArgs {
  final bool isDialog;
  final String email;

  const LoginRouteScreenArgs({
    @required this.isDialog,
    this.email,
  });
}
