import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';

class TwoFactorAuthRoute {
  static const name = "twoFactorAuthRoute";
}

class TwoFactorAuthRouteArgs {
  final bool isDialog;
  final AuthBloc authBloc;
  final TwoFactor state;

  const TwoFactorAuthRouteArgs(
    this.isDialog,
    this.authBloc,
    this.state,
  );
}
