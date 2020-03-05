import 'package:crypto_model/crypto_model.dart';

extension NameUtil on PgpKey {
  String formatName() {
    return identityViewName(name, mail);
  }
}

String identityViewName(String name, String mail) {
  return (name?.isNotEmpty == true ? "${name} " : "") + "<${mail}>";
}
