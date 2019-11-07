import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:uuid/uuid.dart';

@DataClassName("LocalFolder")
class Folders extends Table {
  IntColumn get localId => integer().autoIncrement()();

  TextColumn get guid => text()();

  TextColumn get parentGuid => text().nullable()();

  IntColumn get accountId => integer()();

  IntColumn get type => integer()();

  IntColumn get folderOrder => integer()();

  IntColumn get count => integer().named("messages_count").nullable()();

  IntColumn get unread => integer().nullable()();

  TextColumn get name => text()();

  TextColumn get fullName => text()();

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

  TextColumn get messagesInfoInJson => text().nullable()();

  static Future<List<LocalFolder>> getFolderObjectsFromServerAsync(
      List<Map<String, dynamic>> rawFolders) {
    return compute(getFolderObjectsFromServer, rawFolders);
  }

// returns flat array of items
  static List<LocalFolder> getFolderObjectsFromServer(
      List<Map<String, dynamic>> rawFolders) {
    final uuid = Uuid();

    final flattenedFolders = new List<LocalFolder>();

    void getObj(List<Map<String, dynamic>> rawFolders, String parentGuid) {
      rawFolders.forEach((rawFolder) {
        final guid = uuid.v4();
        final t = rawFolder["Type"];
        flattenedFolders.add(LocalFolder(
          localId: null,
          guid: guid,
          parentGuid: parentGuid,
          accountId: AppStore.authState.accountId,
          type: rawFolder["Type"],
          folderOrder: rawFolders.indexOf(rawFolder),
          name: rawFolder["Name"],
          fullName: rawFolder["FullName"],
          fullNameRaw: rawFolder["FullNameRaw"],
          fullNameHash: rawFolder["FullNameHash"],
          folderHash: "",
          delimiter: rawFolder["Delimiter"],
          needsInfoUpdate: true,
          // the folder is system if it's inbox, sent or drafts
          isSystemFolder: t == 1 || t == 2 || t == 3,
          isSubscribed: rawFolder["IsSubscribed"],
          isSelectable: rawFolder["IsSelectable"],
          folderExists: rawFolder["Exists"],
          extended: rawFolder["Extended"],
          alwaysRefresh: rawFolder["AlwaysRefresh"],
        ));

        if (rawFolder["SubFolders"] != null) {
          getObj(
              new List<Map<String, dynamic>>.from(
                  rawFolder["SubFolders"]["@Collection"]),
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

  // TODO VO: folders might change their order
  static FoldersDiffCalcResult _calculateFoldersDiff(
      Map<String, List<LocalFolder>> args) {
    final oldFolders = args["oldItems"];
    final newFolders = args["newItems"];

    final addedFolders = newFolders.where((i) =>
        oldFolders.firstWhere((j) => j.fullNameHash == i.fullNameHash,
            orElse: () => null) ==
        null);

    final removedFolders = oldFolders.where((i) =>
        newFolders.firstWhere((j) => j.fullNameHash == i.fullNameHash,
            orElse: () => null) ==
        null);

    print("""
    Folders diff calcultaion finished:
      removed: ${removedFolders.length}
      added: ${addedFolders.length}
    """);

    return new FoldersDiffCalcResult(
      addedFolders: addedFolders,
      deletedFolders: removedFolders,
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
      print("Diff calcultaion finished: no changes");
      return new MessagesInfoDiffCalcResult(
          updatedInfo: oldInfo, removedUids: [], infosToUpdateFlags: []);
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

    print("""
    Messages info diff calcultaion finished:
      unchanged: ${unchangedMessages.length}
      changedParent: ${changedParent.length}
      changedFlags: ${changedFlags.length}
      removed: ${removedMessages.length}
      added: ${addedMessages.length}
    """);

    final removedUids = removedMessages.map((m) => m.uid).toList();
    final changedParentUid = changedParent.map((m) => m.uid).toList();

    // update flags directly without deleting the messages
    changedFlags.forEach((info) => info.hasBody = true);

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

  FoldersDiffCalcResult(
      {@required this.addedFolders, @required this.deletedFolders})
      : assert(addedFolders != null, deletedFolders != null);
}

class MessagesInfoDiffCalcResult {
  final List<MessageInfo> updatedInfo;
  final List<int> removedUids;
  final List<MessageInfo> infosToUpdateFlags;

  MessagesInfoDiffCalcResult(
      {@required this.updatedInfo,
      @required this.removedUids,
      @required this.infosToUpdateFlags})
      : assert(updatedInfo != null &&
            removedUids != null &&
            infosToUpdateFlags != null);
}
