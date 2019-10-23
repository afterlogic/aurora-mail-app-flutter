import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:flutter/cupertino.dart';

enum FolderTypes {
  inbox,
  sent,
  drafts,
  spam,
  trash,
  virus,
  starred,
  template,
  system,
  user,
  unknown,
}

class Folder {
  final int localId;

  final String guid;

  final String parentGuid;

  final int type;

  final FolderTypes folderType;

  final int order;

  final String name;

  final String fullName;

  final String fullNameRaw;

  final String fullNameHash;

  final String delimiter;

  final bool isSubscribed;

  final bool isSelectable;

  final bool exists;

  final bool extended;

  final bool alwaysRefresh;

  final List messagesInfo;
  final List<Folder> subFolders;

  Folder({
    @required this.localId,
    @required this.guid,
    @required this.parentGuid,
    @required this.type,
    @required this.folderType,
    @required this.order,
    @required this.name,
    @required this.fullName,
    @required this.fullNameRaw,
    @required this.fullNameHash,
    @required this.delimiter,
    @required this.isSubscribed,
    @required this.isSelectable,
    @required this.exists,
    @required this.extended,
    @required this.alwaysRefresh,
    @required this.messagesInfo,
    @required this.subFolders,
  });

  static FolderTypes _getFolderTypeFromNumber(int num) {
    switch (num) {
      case 1:
        return FolderTypes.inbox;
      case 2:
        return FolderTypes.sent;
      case 3:
        return FolderTypes.drafts;
      case 4:
        return FolderTypes.spam;
      case 5:
        return FolderTypes.trash;
      case 6:
        return FolderTypes.virus;
      case 7:
        return FolderTypes.starred;
      case 8:
        return FolderTypes.template;
      case 9:
        return FolderTypes.system;
      case 10:
        return FolderTypes.user;
      default:
        return FolderTypes.unknown;
    }
  }

  static List<Folder> getFolderObjectsFromDb(List<LocalFolder> localFolders,
      [String parentGuid]) {
    try {
      return localFolders
          .where((lFolder) => lFolder.parentGuid == parentGuid)
          .map((localFolder) {
        return Folder(
          localId: localFolder.localId,
          guid: localFolder.guid,
          parentGuid: localFolder.parentGuid,
          type: localFolder.type,
          folderType: _getFolderTypeFromNumber(localFolder.type),
          order: localFolder.folderOrder,
          name: localFolder.name,
          fullName: localFolder.fullName,
          fullNameRaw: localFolder.fullNameRaw,
          fullNameHash: localFolder.fullNameHash,
          delimiter: localFolder.delimiter,
          isSubscribed: localFolder.isSubscribed,
          isSelectable: localFolder.isSelectable,
          exists: localFolder.folderExists,
          extended: localFolder.extended,
          alwaysRefresh: localFolder.alwaysRefresh,
          messagesInfo: localFolder.messagesInfoInJson == null
              ? null
              : json.decode(localFolder.messagesInfoInJson),
          subFolders: getFolderObjectsFromDb(localFolders, localFolder.guid),
        );
      }).toList();
    } catch (err, s) {
      print("getFolderObjectsFromDb err: $err");
      print("getFolderObjectsFromDb s: $s");
      return null;
    }
  }
}
