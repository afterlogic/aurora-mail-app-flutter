import 'dart:async';

import 'package:aurora_mail/background/alarm/alarm.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_methods.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _methods = new AuthMethods();

  static String hostName;

  static String get apiUrl => "$hostName/?Api/";

  static Account currentAccount;

  static User currentUser;

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is InitUserAndAccounts) yield* _initUserAndAccounts(event);
    if (event is GetLastEmail) yield* _getLastEmail(event);
    if (event is LogIn) yield* _login(event);
    if (event is LogOut) yield* _logout(event);
    if (event is UpdateUser) yield* _setUser(event);
  }

  Stream<AuthState> _initUserAndAccounts(InitUserAndAccounts event) async* {
    final result = await _methods.getUserAndAccountsFromDB();

    try {
      if (result != null) {
        currentUser = result.user;
        hostName = result.user.hostname;
        currentAccount = result.accounts[0];
        yield InitializedUserAndAccounts(result.user, needsLogin: false);
      } else {
        yield InitializedUserAndAccounts(null, needsLogin: true);
      }
    } catch (err, s) {
      print("_initUserAndAccounts err: $err");
      print("_initUserAndAccounts s: $s");
      yield InitializedUserAndAccounts(null, needsLogin: true);
    }
  }

  Stream<AuthState> _getLastEmail(GetLastEmail event) async* {
    final email = await _methods.lastEmail;
    if (email != null) yield ReceivedLastEmail(email);
  }

  Stream<AuthState> _login(LogIn event) async* {
    yield LoggingIn();

    try {
      final user = await _methods.login(
        email: event.email,
        password: event.password,
        host: event.hostname,
      );

      if (user == null) {
        yield NeedsHost();
      } else {
        hostName = user.hostname;
        currentUser = user;
        final accounts = await _methods.getAccounts(user.serverId);

        if (accounts.isNotEmpty) {
          assert(accounts[0] != null);
          currentAccount = accounts[0];
          yield LoggedIn(user);
        } else {
          yield AuthError("error_login_no_accounts");
        }
      }
    } catch (err, s) {
      yield AuthError(formatError(err, s));
    }
  }

  Stream<AuthState> _logout(LogOut event) async* {
    await Alarm.cancel();
    try {
      await _methods.logout(currentUser);
      currentUser = null;
      currentAccount = null;

      yield LoggedOut();
    } catch (err, s) {
      yield AuthError(formatError(err, s));
    }
  }

  Stream<AuthState> _setUser(UpdateUser event) async* {
    currentUser = event.updatedUser;
  }
}
