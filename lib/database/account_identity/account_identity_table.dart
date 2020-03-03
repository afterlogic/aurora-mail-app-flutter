import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("AccountIdentityDb")
class AccountIdentity extends Table {
  @override
  Set<Column> get primaryKey => {entityId, idUser};

  IntColumn get entityId => integer()();

  TextColumn get email => text()();

  TextColumn get friendlyName => text()();

  TextColumn get signature => text()();

  IntColumn get idUser => integer()();

  IntColumn get idAccount => integer()();

  BoolColumn get isDefault => boolean()();

  BoolColumn get useSignature => boolean()();
}

class AccountIdentityDbMap {
  AccountIdentityDbMap._();

  static AccountIdentityDb fromNetwork(Map<String, dynamic> map) {
    return AccountIdentityDb(
      entityId: map["EntityId"] as int,
      email: map["Email"] as String,
      friendlyName: map["FriendlyName"] as String,
      signature: map["Signature"] as String,
      idUser: map["IdUser"] as int,
      idAccount: map["IdAccount"] as int,
      isDefault: map["Default"] as bool,
      useSignature: map["UseSignature"] as bool,
    );
  }
}
