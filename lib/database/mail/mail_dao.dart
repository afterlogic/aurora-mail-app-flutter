import 'dart:convert';
import 'dart:math';

import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

import '../app_database.dart';
import 'mail_table.dart';

part 'mail_dao.g.dart';

// TODO in all daos, make sure to select specific account's messages/folders

@DriftAccessor(tables: [Mail])
class MailDao extends DatabaseAccessor<AppDatabase> with _$MailDaoMixin {
  MailDao(AppDatabase db) : super(db);

//  Future<List<Message>> getMessages(String folder) {
//    return (select(mail)
//          ..where((m) => m.folder.equals(folder))
//          ..orderBy([
//            (m) => OrderingTerm(expression: m.receivedOrDateTimeStampInUTC)
//          ]))
//        .get();
//  }

  Stream<List<Message>> getMessages(
    String folder,
    int userLocalId,
    List<SearchParams> searchParams,
    int accountEntityId,
    bool starredOnly,
    bool unreadOnly,
    int limit,
    int offset,
  ) {
    List<Variable> params = [];
    final fields = <GeneratedColumn>{};
    fields.add(mail.uid);
    fields.add(mail.localId);
    fields.add(mail.extendInJson);
    fields.add(mail.parentUid);
    fields.add(mail.flagsInJson);
    fields.add(mail.subject);
    fields.add(mail.fromToDisplay);
    fields.add(mail.toToDisplay);
    fields.add(mail.hasAttachments);
    fields.add(mail.timeStampInUTC);
    fields.add(mail.folder);

    var query =
        "SELECT ${fields.map((item) => item.escapedName).join(",")} FROM ";

    query += "${mail.actualTableName} WHERE ";
    query += "${mail.accountEntityId.escapedName} = ? ";
    query += "AND ${mail.hasBody.escapedName} = 1 ";
    params.add(Variable.withInt(accountEntityId));

    query += "AND ${mail.folder.escapedName} = ? ";
    params.add(Variable.withString(folder));

    searchParams.forEach((item) {
      final searchTerm = item.value;
      if (item.pattern == SearchPattern.Email) {
        query +=
            "AND (${mail.toForSearch.escapedName} LIKE ? OR ${mail.fromForSearch.escapedName} LIKE ? OR ${mail.ccForSearch.escapedName} LIKE ? OR ${mail.bccForSearch.escapedName} LIKE ?) ";
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
      } else if (item.pattern == SearchPattern.From) {
        query += "AND (${mail.fromForSearch.escapedName} LIKE ?) ";
        params.add(Variable.withString("%$searchTerm%"));
      } else if (item.pattern == SearchPattern.To) {
        query += "AND (${mail.toForSearch.escapedName} LIKE ?) ";
        params.add(Variable.withString("%$searchTerm%"));
      } else if (item.pattern == SearchPattern.Subject) {
        query += "AND (${mail.subject.escapedName} LIKE ?) ";
        params.add(Variable.withString("%$searchTerm%"));
      } else if (item.pattern == SearchPattern.Attachment) {
        query += "AND (${mail.attachmentsForSearch.escapedName} LIKE ?) ";
        params.add(Variable.withString("%$searchTerm%"));
      } else if (item.pattern == SearchPattern.Text) {
        query += "AND (${mail.bodyForSearch.escapedName} LIKE ?) ";
        params.add(Variable.withString("%$searchTerm%"));
      } else if (item.pattern == SearchPattern.Date) {
        final date = item as DateSearchParams;
        if (date.since != null) {
          params.add(
            Variable.withInt(date.since.millisecondsSinceEpoch ~/ 1000),
          );
          query += "AND (${mail.timeStampInUTC.escapedName} > ?) ";
        }
        if (date.till != null) {
          final till = DateTime(
              date.till.year, date.till.month, date.till.day, 23, 59, 59);

          params.add(
            Variable.withInt(till.millisecondsSinceEpoch ~/ 1000),
          );
          query += "AND (${mail.timeStampInUTC.escapedName} < ?) ";
        }
      } else if (item.pattern == SearchPattern.Has) {
        final flag = item as HasSearchParams;
        if (flag.flags?.contains(SearchFlag.Attachment) == true) {
          query += "AND (${mail.hasAttachments.escapedName} = ?) ";
          params.add(
            Variable.withBool(true),
          );
        }
      } else if (item.pattern == SearchPattern.Default &&
          searchTerm != null &&
          searchTerm.isNotEmpty) {
        query +=
            "AND (${mail.subject.escapedName} LIKE ? OR ${mail.toForSearch.escapedName} LIKE ? OR ${mail.fromForSearch.escapedName} LIKE ? OR ${mail.ccForSearch.escapedName} LIKE ? OR ${mail.bccForSearch.escapedName} LIKE ? OR ${mail.bodyForSearch.escapedName} LIKE ? OR ${mail.attachmentsForSearch.escapedName} LIKE ?) ";
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
      }
    });
    if (starredOnly) {
      query += "AND ${mail.flagsInJson.escapedName} LIKE ? ";
      params.add(Variable.withString("%\\flagged%"));
    }
    //todo
    if (unreadOnly) {
      query += "AND ${mail.flagsInJson.escapedName} NOT LIKE ? ";
      params.add(Variable.withString("%\\seen%"));
    }

    query += "ORDER BY ${mail.timeStampInUTC.escapedName} DESC ";
    query += "LIMIT ? OFFSET ? ";

    params.add(Variable.withInt(limit));
    params.add(Variable.withInt(offset));

    return customSelect(query, variables: params, readsFrom: {mail})
        .watch()
        .map((list) {
      return list.map((item) {
        return Message.fromData(item.data);
      }).toList();
    });
  }

  Future<Message> getMessage(int localId) {
    return (select(mail)..where((item) => item.localId.equals(localId)))
        .getSingle();
  }

  Future<Message?> getMessageById(String messageId, String folder) {
    return (select(mail)
          ..where((item) => item.messageId.equals(messageId))
          ..where((item) => item.folder.equals(folder)))
        .get()
        .then((value) {
      if (value.isNotEmpty) {
        return value.first;
      } else {
        return null;
      }
    });
  }

  Future<Message> fillMessage(Message newMessage) async {
    final localId =
        await into(mail).insert(newMessage, mode: InsertMode.replace);
    return newMessage.copyWith(localId: localId);
  }

  Future<void> fillMessages(List<Message> newMessages) async {
    try {
      await batch((batch) {
        batch.insertAll(mail, newMessages, mode: InsertMode.replace);
      });
    } catch (err) {
      print("addMessages err: ${err}");
    }
  }

  Future<void> updateMessagesFlags(List<MessageInfo> infos) async {
    return transaction(() async {
      for (final info in infos) {
        await (update(mail)..where((m) => m.uid.equals(info.uid))).write(
            new MailCompanion(flagsInJson: Value(json.encode(info.flags))));
      }
    });
  }

  Future deleteMessages(List<int> uids, String folderRawName) async {
    final step = 100;
    for (int i = 0; i <= uids.length ~/ step; i++) {
      final start = i * step;
      final end = min(start + step, uids.length);
      await (delete(mail)
            ..where((m) => m.uid.isIn(uids.getRange(start, end)))
            ..where((m) => m.folder.equals(folderRawName)))
          .go();
    }
  }

  Future clearFolder(String folderRawName) {
    return (delete(mail)..where((m) => m.folder.equals(folderRawName))).go();
  }

  Future<int> deleteMessagesFromRemovedFolders(
      List<String> removedFoldersRawNames) async {
    final deletedMessages = await (delete(mail)
          ..where((m) => m.folder.isIn(removedFoldersRawNames)))
        .go();

    print("deleted messages from removed folders: $deletedMessages");

    return deletedMessages;
  }

  Future<int> deleteMessagesOfUser(int userLocalId) {
    return (delete(mail)..where((m) => m.userLocalId.equals(userLocalId))).go();
  }

  Future<Message> getMessageByUid(
    int uid,
    String folder,
    Account account,
    User user,
  ) {
    return (select(mail)
          ..where((tbl) => tbl.accountEntityId.equals(account.entityId))
          ..where((tbl) => tbl.folder.equals(folder))
          ..where((tbl) => tbl.userLocalId.equals(user.localId))
          ..where((tbl) => tbl.uid.equals(uid)))
        .getSingle();
  }

  Future<List<Message>> getMessageWithNotBody(
    List<int> uids,
    Account account,
    User user,
  ) {
    return (select(mail)
          ..where((tbl) => tbl.accountEntityId.equals(account.entityId))
          ..where((tbl) => tbl.userLocalId.equals(user.localId))
          ..where((tbl) => tbl.uid.isIn(uids))
          ..where((tbl) => tbl.hasBody.equals(false)))
        .get();
  }

  Future addEmptyMessages(
    List<MessageInfo> messagesInfo,
    Account account,
    User user,
    String folder,
  ) {
    final uniqueUidInFolder = "${account.entityId}${account.localId}$folder";
    final messages = messagesInfo.map((messageInfo) {
      return Message(
        folder: folder,
        localId: null,
        accountEntityId: account.entityId,
        userLocalId: user.localId,
        uniqueUidInFolder: "$uniqueUidInFolder${messageInfo.uid}",
        uid: messageInfo.uid,
        parentUid: messageInfo.parentUid,
        hasThread: messageInfo.hasThread,
        flagsInJson: json.encode(messageInfo.flags),
        hasBody: false,
        htmlBody: "",
        rawBody: "",
      );
    }).toList();
    return batch((bath) {
      bath.insertAll(
        mail,
        messages,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<Message> addEmptyMessage(
    MessageInfo messageInfo,
    Account account,
    User user,
    String folder,
  ) async {
    final uniqueUidInFolder = "${account.entityId}${account.localId}$folder";
    final messages = Message(
      folder: folder,
      localId: null,
      accountEntityId: account.entityId,
      userLocalId: user.localId,
      uniqueUidInFolder: "$uniqueUidInFolder${messageInfo.uid}",
      uid: messageInfo.uid,
      parentUid: messageInfo.parentUid,
      hasThread: messageInfo.hasThread,
      flagsInJson: json.encode(messageInfo.flags),
      hasBody: false,
      htmlBody: "",
      rawBody: "",
    );
    final localId = await into(mail).insert(messages);
    return messages.copyWith(localId: localId);
  }
}
