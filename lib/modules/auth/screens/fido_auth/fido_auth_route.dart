import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_state.dart';

class FidoAuthRoute {
  static const name = "IosFidoAuthRoute";
}

class FidoAuthRouteArgs {
  final bool isDialog;
  final AuthBloc authBloc;
  final TwoFactor state;

  const FidoAuthRouteArgs(
    this.isDialog,
    this.authBloc,
    this.state,
  );
}
