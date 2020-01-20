import 'package:aurora_mail/database/accounts/accounts_dao.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/modules/auth/repository/auth_api.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_dao.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/groups/contacts_groups_dao.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/storages/contacts_storages_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:moor_flutter/moor_flutter.dart';

class AuthMethods {
  final _authApi = new AuthApi();
  final _authLocal = new AuthLocalStorage();
  final _usersDao = new UsersDao(DBInstances.appDB);
  final _accountsDao = new AccountsDao(DBInstances.appDB);

  Future<InitializerResponse> getUserAndAccountsFromDB() async {
    final selectedUserId = await _authLocal.getSelectedUserLocalId();
    if (selectedUserId == null) return null;

    final futures = [
      _usersDao.getUserByLocalId(selectedUserId),
      _accountsDao.getAccounts(selectedUserId),
    ];

    // TODO getSelectedAccountId and select it

    final result = await Future.wait(futures);
    final user = result[0] as User;
    final accounts = List<Account>.from(result[1] as Iterable);

    if (user == null || accounts.isEmpty) return null;

    // else
    return InitializerResponse(user, accounts);
  }

  Future<void> selectUser(int userLocalId) async {
    return _authLocal.setSelectedUserLocalId(userLocalId);
  }

  // returns null the host field needs to be revealed because auto discover was unsuccessful
  Future<User> login({
    @required String email,
    @required String password,
    @required String host,
  }) async {
    // auto discover domain
    String hostname = host;
    if (hostname.isEmpty) {
      final autoDiscoveredHost = await _authApi.autoDiscoverHostname(email);
      if (autoDiscoveredHost == null || autoDiscoveredHost.isEmpty) {
        return null;
      } else {
        hostname = autoDiscoveredHost;
      }
    }

    // hostname is implied not to be empty
    hostname = hostname.startsWith("http") ? hostname : "https://$hostname";

    final newUser = await _authApi.login(email, password, hostname);

    User userToReturn = await _usersDao.getUserByEmail(newUser.emailFromLogin);

    if (userToReturn == null) {
      await _usersDao.addUser(newUser);
      userToReturn = await _usersDao.getUserByEmail(newUser.emailFromLogin);
    }
    selectUser(userToReturn.localId);
    _authLocal.setLastEmail(email);
    return userToReturn;
  }

  Future<String> get lastEmail => _authLocal.getLastEmail();

  Future<List<User>> get users => _usersDao.getUsers();

  Future<List<Account>> getAccounts(User user) async {
    final accounts = await _authApi.getAccounts(user);
    // ignore unique constraint errors from the db
    try {
      await _accountsDao.addAccounts(accounts);
      final accountsWithLocalIds = await _accountsDao.getAccounts(user.localId);
      await _authLocal.setSelectedAccountId(accountsWithLocalIds[0].localId);
    } catch (err) {}
    return _accountsDao.getAccounts(user.localId);
  }

  Future<void> logout(User user) async {
    _authApi.logout(user);

    final futures = [
      _authLocal.deleteSelectedUserLocalId(),
      _authLocal.deleteSelectedAccountId(),
      _usersDao.deleteUser(user.localId),
      _accountsDao.deleteAccountsOfUser(user.localId),
    ];

    await Future.wait(futures);
  }

  Future<void> deleteUserRelatedData(User user) async {
    final mailDao = new MailDao(DBInstances.appDB);
    final foldersDao = new FoldersDao(DBInstances.appDB);
    final contactsDao = new ContactsDao(DBInstances.appDB);
    final contactsStoragesDao = new ContactsStoragesDao(DBInstances.appDB);
    final contactsGroupsDao = new ContactsGroupsDao(DBInstances.appDB);

    // TODO VO: storages are not deleted
    final futures = [
      _accountsDao.deleteAccountsOfUser(user.localId),
      foldersDao.deleteFoldersOfUser(user.localId),
      mailDao.deleteMessagesOfUser(user.localId),
      contactsDao.deleteContactsOfUser(user.localId),
      contactsStoragesDao.deleteStoragesOfUser(user.localId),
      contactsGroupsDao.deleteGroupsOfUser(user.localId),
    ];

    await Future.wait(futures);
  }

  Future<User> invalidateToken(int userLocalId) async {
    await _usersDao.updateUser(userLocalId, UsersCompanion(token: Value(null)));
    return _usersDao.getUserByLocalId(userLocalId);
  }
}

class InitializerResponse {
  final User user;
  final List<Account> accounts;

  InitializerResponse(this.user, this.accounts);
}
