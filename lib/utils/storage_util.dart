//@dart=2.9
import 'package:aurora_mail/res/str/s.dart';

int getStorageName(String storage) {
  switch (storage) {
    case "STORAGE_ALL":
      return S.contacts_drawer_storage_all;
    case "STORAGE_TEAM":
      return S.contacts_drawer_storage_team;
    case "STORAGE_SHARED":
      return S.contacts_drawer_storage_shared;
    case "STORAGE_PERSONAL":
      return S.contacts_drawer_storage_personal;
    default:
      return null;
  }
}
