import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';

class TrustDeviceRoute {
  static const name = "TrustDeviceRoute";
}

class TrustDeviceRouteArgs {
  final bool isDialog;
  final AuthBloc authBloc;
  final String login;
  final String password;
  final User user;
  final int daysCount;

  const TrustDeviceRouteArgs(
    this.isDialog,
    this.authBloc,
    this.user,
    this.login,
    this.password,
    this.daysCount,
  );
}
