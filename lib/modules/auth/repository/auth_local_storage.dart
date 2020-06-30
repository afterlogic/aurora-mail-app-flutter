import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalStorage {
  final _selectedUserIdKey = "selectedUserId";

  // User local id
  Future<int> getSelectedUserLocalId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_selectedUserIdKey);
  }

  Future<bool> setSelectedUserLocalId(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_selectedUserIdKey, value);
  }

  Future<bool> deleteSelectedUserLocalId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_selectedUserIdKey);
  }

  final _selectedAccountIdKey = "selectedAccountId";

  // Account local id
  Future<int> getSelectedAccountId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_selectedAccountIdKey);
  }

  Future<bool> setSelectedAccountId(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_selectedAccountIdKey, value);
  }

  Future<bool> deleteSelectedAccountId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_selectedAccountIdKey);
  }

  final _lastEmailKey = "lastEmail";

  // User Id
  Future<String> getLastEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastEmailKey);
  }

  Future<bool> setLastEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_lastEmailKey, value);
  }

  final _lastHostKey = "lastHost";

  Future<String> getLastHost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastHostKey);
  }

  Future<bool> setLastHost(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_lastHostKey, value);
  }
}
