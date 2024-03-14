//@dart=2.9

import 'package:aurora_mail/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

String getStorageName(String storage, BuildContext context) {
  switch (storage) {
    case "STORAGE_ALL":
      return S.of(context).contacts_drawer_storage_all;
    case "STORAGE_TEAM":
      return S.of(context).contacts_drawer_storage_team;
    case "STORAGE_SHARED":
      return S.of(context).contacts_drawer_storage_shared;
    case "STORAGE_PERSONAL":
      return S.of(context).contacts_drawer_storage_personal;
    default:
      return null;
  }
}
