import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/models/server_modules.dart';
import 'package:aurora_mail/utils/user_app_data_singleton.dart';
import 'package:flutter/cupertino.dart';

enum FolderType {
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
  notes,
}

extension FolderTypeX on FolderType {
  bool get isNotes => this == FolderType.notes;
}

class FolderNode {
  Folder folder;
  List<FolderNode> children;

  FolderNode(this.folder, this.children);
}

class Folder {
  static const String notesFolderName = "Notes";

  final String guid;

  final String? parentGuid;

  final int accountLocalId;

  final int type;

  final FolderType? folderType;

  final int order;

  final String name;

  final String fullName;

  final String fullNameRaw;

  final String fullNameHash;

  final String folderHash;

  final String delimiter;

  final bool needsInfoUpdate;

  final bool isSystemFolder;

  final bool isSubscribed;

  final bool isSelectable;

  final bool? exists;

  final bool? extended;

  final bool alwaysRefresh;

  final int? count;

  final int? unread;

  final String nameSpace;

  Folder({
    required this.guid,
    required this.parentGuid,
    required this.type,
    required this.folderType,
    required this.order,
    required this.name,
    required this.fullName,
    required this.fullNameRaw,
    required this.fullNameHash,
    required this.folderHash,
    required this.delimiter,
    required this.needsInfoUpdate,
    required this.isSystemFolder,
    required this.isSubscribed,
    required this.isSelectable,
    required this.exists,
    this.extended,
    required this.alwaysRefresh,
    this.count,
    this.unread,
    required this.nameSpace,
    required this.accountLocalId,
  });

  String displayName(BuildContext context, {bool full = false}) {
    switch (this.folderType) {
      case FolderType.inbox:
        return S.of(context).folders_inbox;
      case FolderType.sent:
        return S.of(context).folders_sent;
      case FolderType.drafts:
        return S.of(context).folders_drafts;
      case FolderType.spam:
        return S.of(context).folders_spam;
      case FolderType.trash:
        return S.of(context).folders_trash;
      default:
        if (!full) {
          return name;
        }
        if (fullName.startsWith(nameSpace)) {
          return fullName.substring(nameSpace.length);
        } else {
          return fullName;
        }
    }
  }

  Folder copyWith({FolderType? folderType, int? type}) {
    return Folder(
        guid: guid,
        extended: extended,
        count: count,
        unread: unread,
        parentGuid: parentGuid,
        type: type ?? this.type,
        folderType: folderType ?? this.folderType,
        order: order,
        name: name,
        fullName: fullName,
        fullNameRaw: fullNameRaw,
        fullNameHash: fullNameHash,
        folderHash: folderHash,
        delimiter: delimiter,
        needsInfoUpdate: needsInfoUpdate,
        isSystemFolder: isSystemFolder,
        isSubscribed: isSubscribed,
        isSelectable: isSelectable,
        exists: exists,
        alwaysRefresh: alwaysRefresh,
        nameSpace: nameSpace,
        accountLocalId: accountLocalId);
  }

  static FolderType? getFolderTypeFromNumber(int? num) {
    if (num == null) {
      return null;
    }
    switch (num) {
      case 1:
        return FolderType.inbox;
      case 2:
        return FolderType.sent;
      case 3:
        return FolderType.drafts;
      case 4:
        return FolderType.spam;
      case 5:
        return FolderType.trash;
      case 6:
        return FolderType.virus;
      case 7:
        return FolderType.starred;
      case 8:
        return FolderType.template;
      case 9:
        return FolderType.system;
      case 10:
        return FolderType.user;
      case 11:
        return FolderType.notes;
      default:
        return FolderType.unknown;
    }
  }

  static int? getNumberFromFolderType(FolderType? num) {
    if (num == null) {
      return null;
    }
    switch (num) {
      case FolderType.inbox:
        return 1;
      case FolderType.sent:
        return 2;
      case FolderType.drafts:
        return 3;
      case FolderType.spam:
        return 4;
      case FolderType.trash:
        return 5;
      case FolderType.virus:
        return 6;
      case FolderType.starred:
        return 7;
      case FolderType.template:
        return 8;
      case FolderType.system:
        return 9;
      case FolderType.user:
        return 10;
      case FolderType.notes:
        return 11;
      default:
        return -1;
    }
  }

  static List<Folder>? getFoldersObjectsFromDb(List<LocalFolder> localFolders) {
    try {
      final availableModules =
          UserAppDataSingleton().getAppData?.availableClientModules;

      return localFolders.map((localFolder) {
        return getFolderObjectsFromDb(localFolder,
            notesAvailable:
                availableModules?.contains(ServerModules.notes) ?? false);
      }).toList();
    } catch (err, s) {
      print("getFolderObjectsFromDb err: $err");
      print("getFolderObjectsFromDb s: $s");
      return null;
    }
  }

  static Folder getFolderObjectsFromDb(LocalFolder localFolder,
      {bool notesAvailable = false}) {
    return Folder(
      accountLocalId: localFolder.accountLocalId,
      nameSpace: localFolder.namespace,
      guid: localFolder.guid,
      parentGuid: localFolder.parentGuid,
      type: !notesAvailable && localFolder.type == FolderType.notes.index
          ? FolderType.user.index
          : localFolder.type,
      folderType: !notesAvailable && localFolder.type == FolderType.notes.index
          ? FolderType.user
          : getFolderTypeFromNumber(localFolder.type),
      order: localFolder.folderOrder,
      name: localFolder.name,
      fullName: localFolder.fullName,
      fullNameRaw: localFolder.fullNameRaw,
      fullNameHash: localFolder.fullNameHash,
      folderHash: localFolder.folderHash,
      delimiter: localFolder.delimiter,
      needsInfoUpdate: localFolder.needsInfoUpdate,
      isSystemFolder: localFolder.isSystemFolder,
      isSubscribed: localFolder.isSubscribed,
      isSelectable: localFolder.isSelectable,
      exists: localFolder.folderExists,
      extended: localFolder.extended,
      alwaysRefresh: localFolder.alwaysRefresh,
      count: localFolder.count,
      unread: localFolder.unread,
    );
  }

  static List<FolderNode> getFolderTree(
    List<Folder> folders, [
    String? parentGuid,
  ]) {
    final List<FolderNode> result = [];
    folders.sort((a, b) => a.order - b.order);
    var currentLevelFolders =
        folders.where((e) => e.parentGuid == parentGuid).toList();
    if (_isRootOfNameSpaceStructure(currentLevelFolders)) {
      final rootFolder = currentLevelFolders[0];
      result.add(FolderNode(rootFolder, []));
      currentLevelFolders =
          folders.where((e) => e.parentGuid == rootFolder.guid).toList();
    }
    for (final f in currentLevelFolders) {
      result.add(FolderNode(
        f,
        getFolderTree(folders, f.guid),
      ));
    }
    return result;
  }

  static bool _isRootOfNameSpaceStructure(List<Folder> folders) {
    return folders.length == 1 &&
        folders[0].parentGuid == null &&
        folders[0].nameSpace.isNotEmpty == true &&
        folders[0].fullNameRaw ==
            folders[0].nameSpace.replaceAll(folders[0].delimiter, '');
  }

  static int getFoldersDepth(List<Folder> folders) {
    var result = 0;
    for (final folder in folders) {
      var levelFolder = folder.delimiter.allMatches(folder.fullName).length;
      if (levelFolder > result) result = levelFolder;
    }
    return result;
  }
}
