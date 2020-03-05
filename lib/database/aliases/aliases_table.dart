import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("Aliases")
class AliasesTable extends Table {
  @override
  Set<Column> get primaryKey => {entityId, idUser};

  IntColumn get entityId => integer()();

  TextColumn get email => text()();

  TextColumn get friendlyName => text()();

  TextColumn get signature => text()();

  IntColumn get idUser => integer()();

  IntColumn get idAccount => integer()();

  BoolColumn get useSignature => boolean()();
}

class AliasesMap {
  AliasesMap._();

  static Aliases fromNetwork(Map<String, dynamic> map) {
    return Aliases(
      entityId: map["EntityId"] as int,
      email: map["Email"] as String,
      friendlyName: map["FriendlyName"] as String,
      signature: map["Signature"] as String,
      idUser: map["IdUser"] as int,
      idAccount: map["IdAccount"] as int,
      useSignature: map["UseSignature"] as bool,
    );
  }
}
