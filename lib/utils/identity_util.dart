//@dart=2.9
import 'package:crypto_model/crypto_model.dart';

extension NameUtil on PgpKey {
  String formatName() {
    return IdentityView.solid(name, mail);
  }
}

class IdentityView {
  final String email;
  final String name;

  IdentityView(this.email, this.name);

  static IdentityView fromString(String string) {
    final groups = RegExp("([\\D|\\d]*)?<((?:\\D|\\d)*)>").firstMatch(string);
    String validEmail = "";
    String name = "";
    if (groups?.groupCount == 2) {
      name = groups.group(1);
      validEmail = groups.group(2);
    } else {
      validEmail = string;
    }
    return IdentityView(validEmail, name);
  }

  static String solid(String name, String mail) {
    return (name?.isNotEmpty == true ? "${name} " : "") + "<${mail}>";
  }
}
