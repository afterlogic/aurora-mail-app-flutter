import 'dart:convert';

import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../app_database.dart';
import 'mail_table.dart';

part 'mail_dao.g.dart';

// TODO in all daos, make sure to select specific account's messages/folders

@UseDao(tables: [Mail])
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
  Future<List<Message>> getMessages(
    String folder,
    int userLocalId,
    String searchTerm,
    SearchPattern searchPattern,
    int accountEntityId,
    bool starredOnly,
    int limit,
    int offset,
      bool unreadOnly,
  ) {
    List<Variable> params = [];
    final fields = <GeneratedColumn>{};
    fields.add(mail.uid);
    fields.add(mail.localId);
    fields.add(mail.parentUid);
    fields.add(mail.flagsInJson);
    fields.add(mail.subject);
    fields.add(mail.fromToDisplay);
    fields.add(mail.toToDisplay);
    fields.add(mail.hasAttachments);
    fields.add(mail.timeStampInUTC);
    var query =
        "SELECT ${fields.map((item) => item.$name).join(",")} FROM ${mail.actualTableName} WHERE ";

    query += "account_entity_id = ? ";
    params.add(Variable.withInt(accountEntityId));

    if (searchPattern == SearchPattern.Email) {
      query +=
          "AND (to_in_json LIKE ? OR from_in_json LIKE ? OR cc_in_json LIKE ? OR bcc_in_json LIKE ?) ";
      params.add(Variable.withString("%$searchTerm%"));
      params.add(Variable.withString("%$searchTerm%"));
      params.add(Variable.withString("%$searchTerm%"));
      params.add(Variable.withString("%$searchTerm%"));
    } else {
      query += "AND folder = ? ";
      params.add(Variable.withString(folder));

      if (searchTerm != null && searchTerm.isNotEmpty) {
        query +=
            "AND (subject LIKE ? OR to_in_json LIKE ? OR from_in_json LIKE ? OR cc_in_json LIKE ? OR bcc_in_json LIKE ? OR raw_body LIKE ? OR attachments_for_search LIKE ?) ";
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
      }
    }
    if (starredOnly) {
      query += "AND flags_in_json LIKE ? ";
      params.add(Variable.withString("%\\flagged%"));
    }
    //todo
    statement.where((m) =>
    unreadOnly ? m.flagsInJson.like("%\\seen%").not() : Constant(true));

    query += "ORDER BY time_stamp_in_u_t_c DESC ";
    query += "LIMIT ? OFFSET ? ";

    params.add(Variable.withInt(limit));
    params.add(Variable.withInt(offset));

    return customSelectQuery(query, variables: params).get().then((list) {
      return list.map((item) {
        return Message.fromData(item.data, db);
      }).toList();
    });
  }

  Future<Message> getMessage(int uid) {
    return (select(mail)..where((item) => item.uid.equals(uid))).getSingle();
  }

  Future<void> addMessages(List<Message> newMessages) async {
    try {
      await into(mail).insertAll(newMessages);
    } catch (err) {
//      print("addMessages err: ${err}");
    }
    if (notifyUpdate != null) {
      notifyUpdate();
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

  Future<int> deleteMessages(List<int> uids, String folderRawName) {
    return (delete(mail)
          ..where((m) => m.uid.isIn(uids))
          ..where((m) => m.folder.equals(folderRawName)))
        .go();
  }

  Future<int> deleteMessagesFromRemovedFolders(
      List<String> removedFoldersRawNames) async {
    final deletedMessages = await (delete(mail)
          ..where((m) => isIn(m.folder, removedFoldersRawNames)))
        .go();

    print("deleted messages from removed folders: $deletedMessages");

    return deletedMessages;
  }

  Future<int> deleteMessagesOfUser(int userLocalId) {
    return (delete(mail)..where((m) => m.userLocalId.equals(userLocalId))).go();
  }

  static Function notifyUpdate;
}
