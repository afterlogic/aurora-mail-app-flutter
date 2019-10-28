import 'dart:io';

import 'package:aurora_mail/modules/auth/repository/auth_api.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

part 'auth_state.g.dart';

class AuthState = _AuthState with _$AuthState;

abstract class _AuthState with Store {
  final _authApi = AuthApi();
  final _authLocal = AuthLocalStorage();

  String hostName;

  String get apiUrl => '$hostName/?Api/';

  String authToken;
  int userId;
  int accountId = 10;
  String userEmail;

  @observable
  bool isLoggingIn = false;

  final hostCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  Future<bool> getAuthSharedPrefs() async {
    final List results = await Future.wait([
      _authLocal.getTokenFromStorage(), // 0 - token
      _authLocal.getUserEmailFromStorage(), // 1 - email
      _authLocal.getUserIdFromStorage(), // 2 - id
      _authLocal.getHostFromStorage(), // 3 - host
    ]);
    userEmail = results[1];
    authToken = results[0];
    userId = results[2];
    hostName = results[3];
    return hostName is String &&
        authToken is String &&
        userEmail is String &&
        userId is int;
  }

  Future<void> _setAuthSharedPrefs({
    @required String host,
    @required String token,
    @required String email,
    @required int id,
  }) async {
    await Future.wait([
      _authLocal.setHostToStorage(host),
      _authLocal.setTokenToStorage(token),
      _authLocal.setUserEmailToStorage(email),
      _authLocal.setUserIdToStorage(id),
    ]);
    hostName = host;
    authToken = token;
    userEmail = email;
    userId = id;
  }

  // returns true the host field needs to be revealed because auto discover was unsuccessful
  Future<bool> onLogin(
      {bool isFormValid,
        Function() onSuccess,
        Function() onShowUpgrade,
        Function(String) onError}) async {
    if (isFormValid) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      String email = emailCtrl.text;
      String password = passwordCtrl.text;
      hostName = hostCtrl.text.startsWith("http")
          ? hostCtrl.text
          : "https://${hostCtrl.text}";

      isLoggingIn = true;
      // auto discover domain
      if (hostCtrl.text.isEmpty) {
        final splitEmail = email.split("@");
        final domain = splitEmail.last.trim();
        final autoDiscoveredHost = await _authApi.autoDiscoverHostname(domain);
        if (autoDiscoveredHost == null || autoDiscoveredHost.isEmpty) {
          isLoggingIn = false;
          return true;
        } else {
          hostName = autoDiscoveredHost;
        }
      }

      try {
        final Map<String, dynamic> res = await _authApi.login(email, password);
        final String token = res['Result']['AuthToken'];
        final int id = res['AuthenticatedUserId'];
        await _setAuthSharedPrefs(
            host: hostName, token: token, email: email, id: id);
        onSuccess();
      } catch (err) {
        isLoggingIn = false;
        if (err is SocketException && err.osError.errorCode == 7) {
          onError("\"$hostName\" is not a valid hostname");
        } else if (err == 108) {
          onShowUpgrade();
        } else {
          onError(err.toString());
        }
      }
    }

    return false;
  }

  void onLogout() {
    _authLocal.deleteTokenFromStorage();
    _authLocal.deleteUserIdFromStorage();
    authToken = null;
    userId = null;
  }
}
