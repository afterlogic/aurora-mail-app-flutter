import 'package:shared_preferences/shared_preferences.dart';

class NotificationLocalStorage {
  final selectedUserIdKey = "messageCount";

  // User Id
  Future<int> getMessageCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(selectedUserIdKey);
  }

  Future<bool> setMessageCount(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(selectedUserIdKey, value);
  }

  Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(selectedUserIdKey);
  }
}
