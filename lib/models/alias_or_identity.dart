import 'package:aurora_mail/database/app_database.dart';

class AliasOrIdentity {
  final Aliases alias;
  final AccountIdentity identity;

  AliasOrIdentity(this.alias, this.identity);

  String get name => identity?.friendlyName ?? alias?.friendlyName;

  String get mail => identity?.email ?? alias?.email;

  @override
  int get hashCode => (alias?.hashCode ?? 0) + (identity.hashCode ?? 0);

  bool get isEmpty => alias == null && identity == null;

  @override
  bool operator ==(Object other) => other.hashCode == this.hashCode;
}
