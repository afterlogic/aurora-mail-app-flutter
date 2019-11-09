import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalStorage {
  final selectedUserIdKey = "selectedUserId";

  // User Id
  Future<int> getSelectedUserLocalId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(selectedUserIdKey);
  }

  Future<bool> setSelectedUserLocalId(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(selectedUserIdKey, value);
  }

  Future<bool> deleteSelectedUserLocalId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(selectedUserIdKey);
  }
}
