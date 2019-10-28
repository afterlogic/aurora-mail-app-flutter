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
          ])
    )
        .watch();
  }

  Future<void> addMessages(List<Message> newMessages) {
    return into(mail).insertAll(newMessages);
  }

  Future<void> deleteMessages(List<int> uids) {
    return (delete(mail)..where((m) => isIn(m.uid, uids))).go();
  }
}
