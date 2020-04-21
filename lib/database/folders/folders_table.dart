import 'dart:io';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/logger/logger.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

@DataClassName("LocalFolder")
class Folders extends Table {
  @override
  Set<Column> get primaryKey => {fullName, accountLocalId};

  TextColumn get fullName => text()();

  IntColumn get accountLocalId => integer()();

  IntColumn get userLocalId => integer()();

  TextColumn get guid => text()();

  TextColumn get parentGuid => text().nullable()();

  IntColumn get accountId => integer()();

  IntColumn get type => integer()();

  IntColumn get folderOrder => integer()();

  IntColumn get count => integer().nullable()();

  IntColumn get unread => integer().nullable()();

  TextColumn get name => text()();

  TextColumn get fullNameRaw => text()();

  // for name
  TextColumn get fullNameHash => text()();

  // to check if folder contents changed
  TextColumn get folderHash => text()();

  TextColumn get delimiter => text()();

  BoolColumn get needsInfoUpdate => boolean()();

  BoolColumn get isSystemFolder => boolean()();

  BoolColumn get isSubscribed => boolean()();

  BoolColumn get isSelectable => boolean()();

  BoolColumn get folderExists => boolean()();

  BoolColumn get extended => boolean().nullable()();

  BoolColumn get alwaysRefresh => boolean()();

  TextColumn get namespace => text()();

  static Future<List<LocalFolder>> getFolderObjectsFromServerAsync({
    @required Map<String, dynamic> rawFolders,
    @required int accountId,
    @required int userLocalId,
    @required int accountLocalId,
  }) {
    final args = {
      "id": accountId,
      "userLocalId": userLocalId,
      "accountLocalId": accountLocalId,
      "folders": rawFolders["Folders"]["@Collection"],
      "namespace": rawFolders["Namespace"],
    };

    return compute(getFolderObjectsFromServer, args);
  }

// returns flat array of items
  static List<LocalFolder> getFolderObjectsFromServer(Map args) {
    final uuid = Uuid();
    final accountId = args["id"] as int;
    final userLocalId = args["userLocalId"] as int;
    final accountLocalId = args["accountLocalId"] as int;
    final namespace = (args["namespace"] as String) ?? "";
    final rawFolders =
        new List<Map<String, dynamic>>.from(args["folders"] as Iterable);

    final flattenedFolders = new List<LocalFolder>();

    void getObj(List<Map<String, dynamic>> rawFolders, String parentGuid) {
      rawFolders.forEach((rawFolder) {
        final guid = uuid.v4();
        final t = rawFolder["Type"];
        flattenedFolders.add(LocalFolder(
          namespace: namespace,
          userLocalId: userLocalId,
          accountLocalId: accountLocalId,
          guid: guid,
          parentGuid: parentGuid,
          accountId: accountId,
          type: rawFolder["Type"] as int,
          folderOrder: rawFolders.indexOf(rawFolder),
          name: rawFolder["Name"] as String,
          fullName: rawFolder["FullName"] as String,
          fullNameRaw: rawFolder["FullNameRaw"] as String,
          fullNameHash: rawFolder["FullNameHash"] as String,
          folderHash: "",
          delimiter: rawFolder["Delimiter"] as String,
          needsInfoUpdate: true,
          // the folder is system if it's inbox, sent or drafts
          isSystemFolder: t == 1 || t == 2 || t == 3,
          isSubscribed: rawFolder["IsSubscribed"] as bool,
          isSelectable: rawFolder["IsSelectable"] as bool,
          folderExists: rawFolder["Exists"] as bool,
          extended: rawFolder["Extended"] as bool,
          alwaysRefresh: rawFolder["AlwaysRefresh"] as bool,
        ));

        if (rawFolder["SubFolders"] != null) {
          getObj(
              new List<Map<String, dynamic>>.from(
                  rawFolder["SubFolders"]["@Collection"] as Iterable),
              guid);
        }
      });
    }

    getObj(rawFolders, null);
    return flattenedFolders;
  }

  static Future<FoldersDiffCalcResult> calculateFoldersDiffAsync(
      List<LocalFolder> oldFolders, List<LocalFolder> newFolders) {
    final Map<String, List<LocalFolder>> args = {
      "oldItems": oldFolders,
      "newItems": newFolders,
    };
    return compute(_calculateFoldersDiff, args);
  }

  // TODO folders might change their order
  static FoldersDiffCalcResult _calculateFoldersDiff(
      Map<String, List<LocalFolder>> args) {
    final oldFolders = args["oldItems"];
    final newFolders = args["newItems"];

    final addedFolders = newFolders.where((i) =>
        oldFolders.firstWhere((j) => j.fullNameRaw == i.fullNameRaw,
            orElse: () => null) ==
        null);

    final removedFolders = <LocalFolder>[];
    final updatedFolders = <LocalFolder>[];
    for (var oldFolder in oldFolders) {
      final newFolder = newFolders.firstWhere(
          (j) => j.fullNameRaw == oldFolder.fullNameRaw,
          orElse: () => null);
      if (newFolder == null) {
        removedFolders.add(oldFolder);
      } else {
        updatedFolders.add(
          newFolder.copyWith(guid: oldFolder.guid),
        );
      }
    }

    logger.log("""
    Folders diff calcultaion finished:
      removed: ${removedFolders.length}
      added: ${addedFolders.length}
    """);

    return new FoldersDiffCalcResult(
      addedFolders: addedFolders.toList(),
      deletedFolders: removedFolders.toList(),
      updatedFolders: updatedFolders,
    );
  }

  static Future<MessagesInfoDiffCalcResult> calculateMessagesInfoDiffAsync(
      List<MessageInfo> oldInfo, List<MessageInfo> newInfo) {
    final Map<String, List<MessageInfo>> args = {
      "oldItems": oldInfo,
      "newItems": newInfo,
    };
    return compute(_calculateMessagesInfoDiff, args);
  }

  // you cannot just return newInfo
  // you have to return oldInfo (because it contains hasBody: true) + addedMessages
  static MessagesInfoDiffCalcResult _calculateMessagesInfoDiff(
      Map<String, List<MessageInfo>> args) {
    final oldInfo = args["oldItems"];
    final newInfo = args["newItems"];

    final unchangedMessages = oldInfo.where((i) =>
        newInfo.firstWhere(
            (j) =>
                j.uid == i.uid &&
                j.parentUid == i.parentUid &&
                listEquals(j.flags, i.flags),
            orElse: () => null) !=
        null);

    // no need to calculate difference if all the messages are unchanged
    if (unchangedMessages.length == oldInfo.length &&
        unchangedMessages.length == newInfo.length) {
      logger.log("Diff calcultaion finished: no changes");
      return new MessagesInfoDiffCalcResult(
        updatedInfo: oldInfo,
        removedUids: [],
        infosToUpdateFlags: [],
        addedMessages: [],
      );
    }

    final addedMessages = newInfo.where((i) =>
        oldInfo.firstWhere((j) => j.uid == i.uid, orElse: () => null) == null);

    final removedMessages = oldInfo.where((i) =>
        newInfo.firstWhere((j) => j.uid == i.uid, orElse: () => null) == null);

    final changedParent = newInfo.where((i) =>
        oldInfo.firstWhere((j) => j.uid == i.uid && j.parentUid != i.parentUid,
            orElse: () => null) !=
        null);

    final changedFlags = newInfo.where((i) =>
        oldInfo.firstWhere(
            (j) => j.uid == i.uid && !listEquals(j.flags, i.flags),
            orElse: () => null) !=
        null);

    logger.log("""
    Messages info diff calcultaion finished:
      unchanged: ${unchangedMessages.length}
      changedParent: ${changedParent.length}
      changedFlags: ${changedFlags.length}
      removed: ${removedMessages.length}
      added: ${addedMessages.length}
    """);

    final removedUids = removedMessages.map((m) => m.uid).toList();
    final changedParentUid = changedParent.map((m) => m.uid).toList();

    final List<MessageInfo> updatedInfo = [
      ...addedMessages,
      ...changedParent,
      ...changedFlags,
      ...unchangedMessages
    ];

    return new MessagesInfoDiffCalcResult(
      updatedInfo: updatedInfo,
      removedUids: [...removedUids, ...changedParentUid],
      infosToUpdateFlags: changedFlags.toList(),
      addedMessages: addedMessages.toList(),
    );
  }

  static LocalFolder getFolderOfType(
      List<LocalFolder> folders, FolderType type) {
    return folders.firstWhere(
      (f) => Folder.getFolderTypeFromNumber(f.type) == type,
      orElse: () => null,
    );
  }
}

class FoldersDiffCalcResult {
  final List<LocalFolder> addedFolders;
  final List<LocalFolder> deletedFolders;
  final List<LocalFolder> updatedFolders;

  FoldersDiffCalcResult(
      {@required this.updatedFolders,
      @required this.addedFolders,
      @required this.deletedFolders})
      : assert(addedFolders != null, deletedFolders != null);
}

class MessagesInfoDiffCalcResult {
  final List<MessageInfo> updatedInfo;
  final List<int> removedUids;
  final List<MessageInfo> infosToUpdateFlags;
  final List<MessageInfo> addedMessages;

  MessagesInfoDiffCalcResult(
      {@required this.updatedInfo,
      @required this.removedUids,
      @required this.infosToUpdateFlags,
      @required this.addedMessages})
      : assert(updatedInfo != null &&
            removedUids != null &&
            infosToUpdateFlags != null);
}

class FolderMessageInfo {
  static Future<List<MessageInfo>> getMessageInfo(
    String fullName,
    int accountLocalId,
  ) async {
    final id = "$fullName.$accountLocalId";
    final dir = await getApplicationSupportDirectory();
    final file = File(dir.path + Platform.pathSeparator + id);
    if (await file.exists()) {
      try {
        return MessageInfo.fromJsonString(await file.readAsString());
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future setMessageInfo(
    String fullName,
    int accountLocalId,
    List<MessageInfo> items,
  ) async {
    final id = "$fullName.$accountLocalId";
    final dir = await getApplicationSupportDirectory();
    final file = File(dir.path + Platform.pathSeparator + id);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    try {
      return file.writeAsString(MessageInfo.toJsonString(items));
    } catch (e) {
      return null;
    }
  }

  static final folder = "messageInfo";
}
