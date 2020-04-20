import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'white_mail_model.dart';

part 'white_mail_dao.g.dart';

@UseDao(tables: [WhiteMailTable])
class WhiteMailDao extends DatabaseAccessor<AppDatabase>
    with _$WhiteMailDaoMixin {
  WhiteMailDao(AppDatabase db) : super(db);

  Future add(List<String> emails) {
    return batch((batch) {
      batch.insertAll(whiteMailTable,
          emails.map((email) => WhiteMail(mail: email)).toList(),
          mode: InsertMode.insertOrIgnore);
    });
  }

  Future<Set<String>> get() {
    return select(whiteMailTable)
        .get()
        .then((item) => item.map((item) => item.mail).toSet());
  }
}
