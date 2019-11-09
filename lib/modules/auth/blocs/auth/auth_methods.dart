import 'package:aurora_mail/database/accounts/accounts_dao.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/modules/auth/repository/auth_api.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:flutter/cupertino.dart';

class AuthMethods {
  final _authApi = new AuthApi();
  final _authLocal = new AuthLocalStorage();
  final _usersDao = new UsersDao(DBInstances.appDB);
  final _accountsDao = new AccountsDao(DBInstances.appDB);

  Future<InitializerResponse> getUserAndAccountsFromDB() async {
    final selectedUserLocalId = await _authLocal.getSelectedUserLocalId();
    if (selectedUserLocalId == null) return null;

    final futures = [
      _usersDao.getUserByLocalId(selectedUserLocalId),
      _accountsDao.getAccounts(selectedUserLocalId),
    ];

    final result = await Future.wait(futures);
    final User user = result[0];
    final List<Account> accounts = result[1];

    if (user == null || accounts.isEmpty) return null;

    // else
    return InitializerResponse(user, accounts);
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
      final splitEmail = email.split("@");
      final domain = splitEmail.last.trim();
      final autoDiscoveredHost = await _authApi.autoDiscoverHostname(domain);
      if (autoDiscoveredHost == null || autoDiscoveredHost.isEmpty) {
        return null;
      } else {
        hostname = autoDiscoveredHost;
      }
    }

    // hostname is implied not to be empty
    hostname = hostname.startsWith("http") ? hostname : "https://$hostname";

    final newUser = await _authApi.login(email, password, hostname);

    final user = await _usersDao.getUserByServerId(newUser.serverId);

    int localIdToSaveInSharePrefs;
    if (user != null) {
      localIdToSaveInSharePrefs = user.localId;
    } else {
      localIdToSaveInSharePrefs = await _usersDao.addUser(newUser);
    }
    await _authLocal.setSelectedUserLocalId(localIdToSaveInSharePrefs);
    return newUser;
  }

  Future<List<Account>> getAccounts(int userId) async {
    final accounts = await _authApi.getAccounts(userId);
    // ignore unique constraint errors from the db
    try {
      await _accountsDao.addAccounts(accounts);
    } catch (err) {}
    return accounts;
  }

  Future<void> logout(User user) async {
    final futures = [
      _authLocal.deleteSelectedUserLocalId(),
//      _usersDao.deleteUser(user.localId),
      _accountsDao.deleteAccountsOfUser(user.serverId),
    ];

    await Future.wait(futures);
  }
}

class InitializerResponse {
  final User user;
  final List<Account> accounts;

  InitializerResponse(this.user, this.accounts);
}
