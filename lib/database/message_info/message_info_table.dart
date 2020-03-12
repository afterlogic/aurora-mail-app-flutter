import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("MessageInfoDb")
class MessageInfoTable extends Table {
  @override
  Set<Column> get primaryKey => {uid, folder, accountLocalId};

  TextColumn get folder => text()();

  IntColumn get accountLocalId => integer()();

  IntColumn get uid => integer()();

  IntColumn get parentUid => integer()();

  TextColumn get flags => text()();

  BoolColumn get hasThread => boolean()();

  BoolColumn get hasBody => boolean()();
}

extension MapMessageInfoDb on MessageInfoDb {
  MessageInfo toMessageInfo() {
    return MessageInfo(
      accountLocalId: accountLocalId,
      folder: folder,
      uid: uid,
      parentUid: parentUid,
      flags: flags.split(","),
      hasThread: hasThread,
      hasBody: hasBody,
    );
  }
}

extension MapMessageInfo on MessageInfo {
  MessageInfoDb toMessageInfoDb({int accountLocalId, String folder}) {
    return MessageInfoDb(
      accountLocalId: accountLocalId ?? this.accountLocalId,
      folder: folder ?? this.folder,
      uid: uid,
      parentUid: parentUid,
      flags: flags.join(','),
      hasThread: hasThread,
      hasBody: hasBody,
    );
  }
}
