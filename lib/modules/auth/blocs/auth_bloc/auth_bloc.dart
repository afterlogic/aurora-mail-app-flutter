import 'dart:async';

import 'package:alarm_service/alarm_service.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_methods.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _methods = new AuthMethods();

//  static String hostName;

  Account currentAccount;

  User currentUser;

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is InitUserAndAccounts) yield* _initUserAndAccounts(event);
    if (event is GetLastEmail) yield* _getLastEmail(event);
    if (event is LogIn) yield* _login(event);
    if (event is SelectUser) yield* _selectUser(event);
    if (event is DeleteUser) yield* _deleteUser(event);
    if (event is LogOut) yield* _logOut();
    if (event is InvalidateCurrentUserToken)
      yield* _invalidateCurrentUserToken(event);
    if (event is ChangeAccount) yield* _changeAccount(event);
  }

  Stream<AuthState> _initUserAndAccounts(InitUserAndAccounts event) async* {
    final result = await _methods.getUserAndAccountsFromDB();
    final users = await _methods.users;

    try {
      if (result != null) {
        currentUser = result.user;
        currentAccount = result.account;
        yield InitializedUserAndAccounts(
          user: currentUser,
          users: users,
          needsLogin: false,
          account: currentAccount,
          accounts: result.accounts,
        );
      } else {
        yield InitializedUserAndAccounts(
          user: null,
          users: null,
          needsLogin: true,
          account: null,
          accounts: null,
        );
      }
    } catch (err, s) {
      print("_initUserAndAccounts err: $err");
      print("_initUserAndAccounts s: $s");
      yield InitializedUserAndAccounts(
        user: null,
        users: null,
        needsLogin: true,
        account: null,
        accounts: null,
      );
    }
  }

  Stream<AuthState> _getLastEmail(GetLastEmail event) async* {
    final email = await _methods.lastEmail;
    if (email != null) yield ReceivedLastEmail(email);
  }

  Stream<AuthState> _selectUser(SelectUser event) async* {
    await _methods.selectUser(event.userLocalId);
    yield UserSelected();
    add(InitUserAndAccounts());
  }

  Stream<AuthState> _login(LogIn event) async* {
    yield LoggingIn();
    final users = await _methods.users;
    final userFromDb = users.firstWhere((u) => u.emailFromLogin == event.email,
        orElse: () => null);

    if (userFromDb != null) {
      add(SelectUser(userFromDb.localId));
    } else {
      try {
        final user = await _methods.login(
          email: event.email,
          password: event.password,
          host: event.hostname,
        );

        if (user == null) {
          yield NeedsHost();
        } else {
          final users = await _methods.users;
          currentUser = user;
          final accounts = await _methods.getAccounts(user);

          if (accounts.isNotEmpty) {
            assert(accounts[0] != null);
            currentAccount = accounts[0];
            yield LoggedIn(user, users);
          } else {
            yield AuthError("error_login_no_accounts");
          }
        }
      } catch (err, s) {
        yield AuthError(formatError(err, s));
      }
    }
  }

  Stream<AuthState> _deleteUser(DeleteUser event) async* {
    await AlarmService.removeAlarm(ALARM_ID);
    try {
      await _methods.logout(event.user);
      final users = await _methods.users;

      if (users.isNotEmpty) {
        add(SelectUser(users[0].localId));
      } else {
        yield LoggedOut();
      }
    } catch (err, s) {
      yield AuthError(formatError(err, s));
    }
  }

  Stream<AuthState> _logOut() async* {
    final users = await _methods.users;
    for (var user in users) {
      yield* await _deleteUser(DeleteUser(user));
    }
  }

  Stream<AuthState> _invalidateCurrentUserToken(
      InvalidateCurrentUserToken event) async* {
    if (currentUser != null) {
      currentUser = await _methods.invalidateToken(currentUser.localId);
    } else {
      print("cannot invalidate token, no currentUser selected");
    }
  }

  Stream<AuthState> _changeAccount(ChangeAccount event) async* {
    await _methods.selectAccount(event.account);
    add(InitUserAndAccounts());
  }
}
