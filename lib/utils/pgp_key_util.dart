import 'package:crypto_model/crypto_model.dart';

extension NameUtil on PgpKey {
  String formatName() {
    return formatPgpKeyName(name, mail);
  }
}

String formatPgpKeyName(String name, String mail) {
  return (name?.isNotEmpty == true ? "${name} " : "") + "<${mail}>";
}
