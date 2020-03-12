import 'package:moor_flutter/moor_flutter.dart';

import '../app_database.dart';
import 'message_info_table.dart';

part 'message_info_dao.g.dart';

@UseDao(tables: [MessageInfoTable])
class MessageInfoDao extends DatabaseAccessor<AppDatabase>
    with _$MessageInfoDaoMixin {
  MessageInfoDao(AppDatabase db) : super(db);

  Future<List<MessageInfoDb>> getList(
      int accountLocalId, String folder, int offset, int limit) {
    return (select(messageInfoTable)
          ..where((item) => item.accountLocalId.equals(accountLocalId))
          ..where((item) => item.folder.equals(folder))
          ..limit(limit, offset: offset))
        .get();
  }

  Future<List<MessageInfoDb>> getAll(int accountLocalId, String folder) async {
    final step = 500;
    final items = <MessageInfoDb>[];
    var current = 0;
    var isEnd = false;
    do {
      final list = await getList(accountLocalId, folder, current * step, step);
      isEnd = list.length != step;
      items.addAll(list);
      current++;
    } while (!isEnd);
    return items;
  }

  Future remove(int accountLocalId, String folder, List<int> uid) {
    return (delete(messageInfoTable)
          ..where((item) => item.accountLocalId.equals(accountLocalId))
          ..where((item) => item.folder.equals(folder))
          ..where((item) => item.uid.isIn(uid)))
        .go();
  }

  Future set(int accountLocalId, String folder,
      List<MessageInfoDb> messagesInfo) async {
    await (delete(messageInfoTable)
          ..where((item) => item.accountLocalId.equals(accountLocalId))
          ..where((item) => item.folder.equals(folder)))
        .go();

    return batch((b) {
      return b.insertAll(
        messageInfoTable,
        messagesInfo,
      );
    });
  }
}
