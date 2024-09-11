import 'package:aurora_mail/models/app_data.dart';

class UserAppDataSingleton {
  AppData? _appData;

  static final UserAppDataSingleton _singleton = UserAppDataSingleton._();
  factory UserAppDataSingleton() => _singleton;
  UserAppDataSingleton._() {}

  set setAppData(AppData? appData){
    _appData = appData;
  }

  AppData? get getAppData{
    return _appData;
  }
}