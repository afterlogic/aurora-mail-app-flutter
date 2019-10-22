import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("Message")
class Mail extends Table {
  IntColumn get localId => integer().autoIncrement()();

  IntColumn get uid => integer()();

  TextColumn get messageId => text()();

  TextColumn get folder => text()();

  TextColumn get flagsInJson => text()();

  TextColumn get threadInJson => text().nullable()();

  TextColumn get subject => text()();

  IntColumn get size => integer()();

  IntColumn get textSize => integer()();

  BoolColumn get truncated => boolean()();

  IntColumn get internalTimeStampInUTC => integer()();

  IntColumn get receivedOrDateTimeStampInUTC => integer()();

  IntColumn get timeStampInUTC => integer()();

  TextColumn get toInJson => text()();

  TextColumn get fromInJson => text()();

  TextColumn get cc => text().nullable()();

  TextColumn get bcc => text().nullable()();

  TextColumn get sender => text().nullable()();

  TextColumn get replyTo => text().nullable()();

  BoolColumn get isSeen => boolean()();

  BoolColumn get isFlagged => boolean()();

  BoolColumn get isAnswered => boolean()();

  BoolColumn get isForwarded => boolean()();

  BoolColumn get hasAttachments => boolean()();

  BoolColumn get hasVcardAttachment => boolean()();

  BoolColumn get hasIcalAttachment => boolean()();

  IntColumn get importance => integer()();

  TextColumn get draftInfo => text().nullable()();

  IntColumn get sensitivity => integer()();

  TextColumn get downloadAsEmlUrl => text()();

  TextColumn get hash => text()();

  TextColumn get headers => text()();

  TextColumn get inReplyTo => text()();

  TextColumn get references => text()();

  TextColumn get readingConfirmationAddressee => text()();

  TextColumn get html => text()();

  TextColumn get plain => text()();

  TextColumn get plainRaw => text()();

  BoolColumn get rtl => boolean()();

  TextColumn get extendInJson => text()();

  BoolColumn get safety => boolean()();

  BoolColumn get hasExternals => boolean()();

  TextColumn get foundedCIDsInJson => text()();

  TextColumn get foundedContentLocationUrlsInJson => text()();

  TextColumn get attachmentsInJson => text().nullable()();

  TextColumn get customInJson => text()();
}
