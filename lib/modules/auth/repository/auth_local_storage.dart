import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalStorage {
  final selectedUserIdKey = "selectedUserId";

  // User Id
  Future<int> getSelectedUserServerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(selectedUserIdKey);
  }

  Future<bool> setSelectedUserServerId(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(selectedUserIdKey, value);
  }

  Future<bool> deleteSelectedUserServerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(selectedUserIdKey);
  }

  final lastEmailKey = "lastEmail";

  // User Id
  Future<String> getLastEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastEmailKey);
  }

  Future<bool> setLastEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(lastEmailKey, value);
  }
}
