import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/users/users_table.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'users_dao.g.dart';

@UseDao(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  UsersDao(AppDatabase db) : super(db);

  Future<User> getUserByLocalId(int localId) async {
    final localUsers =
        await (select(users)..where((u) => u.localId.equals(localId))).get();
    if (localUsers.isEmpty) return null;
    return localUsers[0];
  }

  Future<User> getUserByServerId(int serverId) async {
    final localUsers =
        await (select(users)..where((u) => u.serverId.equals(serverId))).get();
    if (localUsers.isEmpty) return null;
    return localUsers[0];
  }

  Future<int> addUser(User newUser) => into(users).insert(newUser);

  Future<void> deleteUser(int localId) {
    return (delete(users)..where((u) => u.localId.equals(localId))).go();
  }

  Future<void> updateUser(int localId, UsersCompanion updatedUser) {
    return (update(users)..where((u) => u.localId.equals(localId)))
        .write(updatedUser);
  }
}
