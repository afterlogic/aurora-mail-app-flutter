import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';

class BackupCodeAuthRoute {
  static const name = "BackupCodeAuthRoute";
}

class BackupCodeAuthRouteArgs {
  final bool isDialog;
  final AuthBloc authBloc;
  final TwoFactor state;

  const BackupCodeAuthRouteArgs(
    this.isDialog,
    this.authBloc,
    this.state,
  );
}
