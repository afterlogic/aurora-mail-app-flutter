import 'package:aurora_mail/database/app_database.dart';

class AliasOrAccount {
  final Account? account;
  final Aliases? alias;

  AliasOrAccount(this.account, this.alias);

  String? get name => alias?.friendlyName ?? account?.friendlyName;

  String? get mail => alias?.email ?? account?.email;

  String? get signature => alias?.signature ?? account?.signature;

  @override
  int get hashCode => (account?.hashCode ?? 0) + (alias.hashCode ?? 0);

  int? get entityId => account?.entityId ?? alias?.entityId;

  bool get isEmpty => account == null && alias == null;

  @override
  bool operator ==(Object other) =>
      other is AliasOrAccount && other.entityId == this.entityId;
}
