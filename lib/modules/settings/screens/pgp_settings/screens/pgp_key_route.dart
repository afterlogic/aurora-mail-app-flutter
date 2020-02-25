import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart';
import 'package:crypto_model/crypto_model.dart';

class PgpKeyRoute {
  static const name = "PgpKeyRoute";
}

class PgpKeyRouteArg {
  final PgpKey pgpKey;
  final PgpSettingsBloc bloc;

  PgpKeyRouteArg(this.pgpKey, this.bloc);
}
