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
        entityId: item["EntityId"],
        idUser: item["IdUser"],
        uuid: item["UUID"],
        parentUuid: item["ParentUUID"],
        moduleName: item["ModuleName"],
        useToAuthorize: item["UseToAuthorize"],
        email: item["Email"],
        friendlyName: item["FriendlyName"],
        useSignature: item["UseSignature"],
        signature: item["Signature"],
        serverId: item["ServerId"],
        foldersOrderInJson: item["FoldersOrder"],
        useThreading: item["UseThreading"],
        saveRepliesToCurrFolder: item["SaveRepliesToCurrFolder"],
        accountId: item["AccountID"],
        allowAutoResponder: item["AllowAutoresponder"],
        allowFilters: item["AllowFilters"],
        allowForward: item["AllowForward"],
      );
    }).toList();
  }
}
