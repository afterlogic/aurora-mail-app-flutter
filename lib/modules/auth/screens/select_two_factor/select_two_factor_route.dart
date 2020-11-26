import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_state.dart';

class SelectTwoFactorRoute {
  static const name = "SelectTwoFactorRoute";
}

class SelectTwoFactorRouteArgs {
  final bool isDialog;
  final AuthBloc authBloc;
  final TwoFactor state;

  const SelectTwoFactorRouteArgs(
    this.isDialog,
    this.authBloc,
    this.state,
  );
}
