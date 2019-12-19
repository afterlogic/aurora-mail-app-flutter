import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

class Accounts extends Table {
  IntColumn get localId => integer().autoIncrement()();

  IntColumn get entityId => integer().customConstraint("UNIQUE")();

  IntColumn get idUser => integer()();

  TextColumn get uuid => text()();

  TextColumn get parentUuid => text()();

  TextColumn get moduleName => text()();

  BoolColumn get useToAuthorize => boolean()();

  TextColumn get email => text()();

  TextColumn get friendlyName => text()();

  BoolColumn get useSignature => boolean()();

  TextColumn get signature => text()();

  IntColumn get serverId => integer()();

  TextColumn get foldersOrderInJson => text()();

  BoolColumn get useThreading => boolean()();

  BoolColumn get saveRepliesToCurrFolder => boolean()();

  IntColumn get accountId => integer()();

  BoolColumn get allowFilters => boolean()();

  BoolColumn get allowForward => boolean()();

  BoolColumn get allowAutoResponder => boolean()();

  static List<Account> getAccountsObjFromServer(List result) {
    return result.map((item) {
      return new Account(
        localId: null,
        entityId: item["EntityId"] as int,
        idUser: item["IdUser"] as int,
        uuid: item["UUID"] as String,
        parentUuid: item["ParentUUID"] as String,
        moduleName: item["ModuleName"] as String,
        useToAuthorize: item["UseToAuthorize"] as bool,
        email: item["Email"] as String,
        friendlyName: item["FriendlyName"] as String,
        useSignature: item["UseSignature"] as bool,
        signature: item["Signature"] as String,
        serverId: item["ServerId"] as int,
        foldersOrderInJson: item["FoldersOrder"] as String,
        useThreading: item["UseThreading"] as bool,
        saveRepliesToCurrFolder: item["SaveRepliesToCurrFolder"] as bool,
        accountId: item["AccountID"] as int,
        allowAutoResponder: item["AllowAutoresponder"] as bool,
        allowFilters: item["AllowFilters"] as bool,
        allowForward: item["AllowForward"] as bool,
      );
    }).toList();
  }
}
