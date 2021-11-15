import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart';

class PgpSettingsRoute {
  static const name = "PgpSettingsRoute";
}

class PgpSettingsRouteArg {
  final PgpSettingsBloc pgpSettingsBloc;

  PgpSettingsRouteArg(this.pgpSettingsBloc);
}
