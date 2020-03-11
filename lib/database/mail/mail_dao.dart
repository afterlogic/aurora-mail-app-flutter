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

  Stream<List<Message>> watchMessages({
    @required String folder,
    @required int userLocalId,
    @required String searchTerm,
    @required SearchPattern searchPattern,
    @required int accountEntityId,
    @required bool starredOnly,
    @required bool unreadOnly,
  }) {
    final statement = select(mail);
    statement.where((m) => m.accountEntityId.equals(accountEntityId));
    if (searchPattern == SearchPattern.Email) {
      statement.where(
        (m) => searchTerm != null && searchTerm.isNotEmpty
            ? m.toInJson.like("%$searchTerm%") |
                m.fromInJson.like("%$searchTerm%") |
                m.ccInJson.like("%$searchTerm%") |
                m.bccInJson.like("%$searchTerm%")
            : Constant(true),
      );
    } else {
      statement.where((m) => m.folder.equals(folder));
      statement.where(
        (m) => searchTerm != null && searchTerm.isNotEmpty
            ? m.subject.like("%$searchTerm%") |
                m.toInJson.like("%$searchTerm%") |
                m.fromInJson.like("%$searchTerm%") |
                m.ccInJson.like("%$searchTerm%") |
                m.bccInJson.like("%$searchTerm%") |
                m.rawBody.like("%$searchTerm%") |
                m.attachmentsForSearch.like("%$searchTerm%")
            : Constant(true),
      );
    }
    statement.where((m) =>
        starredOnly ? m.flagsInJson.like("%\\flagged%") : Constant(true));
    statement.where((m) =>
      unreadOnly ? m.flagsInJson.like("%\\seen%").not() : Constant(true));
    // todo VO: im have exception on account with 462 mails.
    // Pagination?
    statement.limit(400);
    statement.orderBy([
      (m) => OrderingTerm(expression: m.timeStampInUTC, mode: OrderingMode.desc)
    ]);
    return statement.watch();
  }

  Future<void> addMessages(List<Message> newMessages) async {
    try {
      await into(mail).insertAll(newMessages);
    } catch (err) {
//      print("addMessages err: ${err}");
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
}
