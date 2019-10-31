import 'package:moor_flutter/moor_flutter.dart';

import '../app_database.dart';
import 'mail_table.dart';

part 'mail_dao.g.dart';

@UseDao(tables: [Mail])
class MailDao extends DatabaseAccessor<AppDatabase> with _$MailDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  MailDao(AppDatabase db) : super(db);

//  Future<List<Message>> getMessages(String folder) {
//    return (select(mail)
//          ..where((m) => m.folder.equals(folder))
//          ..orderBy([
//            (m) => OrderingTerm(expression: m.receivedOrDateTimeStampInUTC)
//          ]))
//        .get();
//  }

  Stream<List<Message>> watchMessages(String folder) {
    return (select(mail)
          ..where((m) => m.folder.equals(folder))
          ..limit(5000)
          ..orderBy([
            (m) => OrderingTerm(
                expression: m.timeStampInUTC, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Future<void> addMessages(List<Message> newMessages) {
    try {
      return into(mail).insertAll(newMessages);
    } catch (err) {
      print("insertMessages: ${err}");
      return null;
    }
  }

  Future<int> deleteMessages(List<int> uids) {
    return (delete(mail)..where((m) => isIn(m.uid, uids))).go();
  }

  Future<int> deleteMessagesFromRemovedFolders(
      List<String> removedFoldersRawNames) async {
    final deletedMessages = await (delete(mail)
          ..where((m) => isIn(m.folder, removedFoldersRawNames)))
        .go();

    print("deleted messages from removed folders: $deletedMessages");

    return deletedMessages;
  }
}
