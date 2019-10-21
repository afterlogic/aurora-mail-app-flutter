import 'package:moor_flutter/moor_flutter.dart';

import '../app_database.dart';
import 'mail_table.dart';

part 'mail_dao.g.dart';

@UseDao(tables: [Mail])
class MailDao extends DatabaseAccessor<AppDatabase> with _$MailDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  MailDao(AppDatabase db) : super(db);
}