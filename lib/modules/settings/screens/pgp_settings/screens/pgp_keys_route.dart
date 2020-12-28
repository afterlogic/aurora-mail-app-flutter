import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart';
import 'package:crypto_model/crypto_model.dart';

class PgpKeysRoute {
  static const name = "PgpKeysRoute";
}

class PgpKeysRouteArg {
  final List<PgpKey> pgpKeys;

  PgpKeysRouteArg(this.pgpKeys);
}
