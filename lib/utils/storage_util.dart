import 'package:aurora_mail/res/str/s.dart';
int getStorageName(String storage) {
  switch (storage) {
    case "all":
      return S.contacts_drawer_storage_all;
    case "team":
      return S.contacts_drawer_storage_team;
    case "shared":
      return S.contacts_drawer_storage_shared;
    case "personal":
      return S.contacts_drawer_storage_personal;
    default:
      return null;
  }
}