import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';

class TwoFactorAuthRoute {
  static const name = "twoFactorAuthRoute";
}

class TwoFactorAuthRouteArgs {
  final bool isDialog;
  final String host;
  final String login;
  final String password;
  final AuthBloc authBloc;

  const TwoFactorAuthRouteArgs(
    this.host,
    this.login,
    this.password,
    this.isDialog,
    this.authBloc,
  );
}
