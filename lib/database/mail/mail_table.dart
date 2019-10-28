import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/utils/constants.dart';
import 'package:aurora_mail/utils/custom_exception.dart';
import 'package:moor_flutter/moor_flutter.dart';

enum MessageFlags {
  answered,
  seen,
  starred,
  forwarded,
}

@DataClassName("Message")
class Mail extends Table {
  IntColumn get localId => integer().autoIncrement()();

  IntColumn get uid => integer().customConstraint("UNIQUE")();

  IntColumn get parentUid => integer().nullable()();

  TextColumn get messageId => text()();

  TextColumn get folder => text()();

  TextColumn get flagsInJson => text()();

  BoolColumn get hasThread => boolean()();

  TextColumn get subject => text()();

  IntColumn get size => integer()();

  IntColumn get textSize => integer()();

  BoolColumn get truncated => boolean()();

  IntColumn get internalTimeStampInUTC => integer()();

  IntColumn get receivedOrDateTimeStampInUTC => integer()();

  IntColumn get timeStampInUTC => integer()();

  TextColumn get toInJson => text().nullable()();

  TextColumn get fromInJson => text().nullable()();

  TextColumn get fromToDisplay => text()();

  TextColumn get ccInJson => text().nullable()();

  TextColumn get bccInJson => text().nullable()();

  TextColumn get senderInJson => text().nullable()();

  TextColumn get replyToInJson => text().nullable()();

//  BoolColumn get isSeen => boolean()();
//
//  BoolColumn get isFlagged => boolean()();
//
//  BoolColumn get isAnswered => boolean()();
//
//  BoolColumn get isForwarded => boolean()();

  BoolColumn get hasAttachments => boolean()();

  BoolColumn get hasVcardAttachment => boolean()();

  BoolColumn get hasIcalAttachment => boolean()();

  IntColumn get importance => integer()();

  TextColumn get draftInfoInJson => text().nullable()();

  IntColumn get sensitivity => integer()();

  TextColumn get downloadAsEmlUrl => text()();

  TextColumn get hash => text()();

  TextColumn get headers => text()();

  TextColumn get inReplyTo => text()();

  TextColumn get references => text().named("message_references")();

  TextColumn get readingConfirmationAddressee => text()();

  TextColumn get htmlRaw => text().nullable()();

  TextColumn get html => text().nullable()();

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

  static List<MessageFlags> getFlags(String flagsInJson) {
    final flags = json.decode(flagsInJson);
    final messageFlags = new List<MessageFlags>();
    if (flags.contains("\\seen")) messageFlags.add(MessageFlags.seen);
    if (flags.contains("\\answered")) messageFlags.add(MessageFlags.answered);
    if (flags.contains("\\flagged")) messageFlags.add(MessageFlags.starred);
    if (flags.contains("\$forwarded")) messageFlags.add(MessageFlags.forwarded);
    return messageFlags;
  }

  static List<Sender> getSenders(String toFrom) {
    final decoded = json.decode(toFrom);
    if (decoded is Map && decoded["@Collection"] is List) {
      return decoded["@Collection"].map((rawSender) {
        return new Sender(
          displayName: rawSender["DisplayName"],
          email: rawSender["Email"],
        );
      }).toList();
    } else {
      // TODO VO: for debug
      throw Exception("Could not get sender");
    }
  }

  static List<Message> getMessageObjFromServerAndUpdateInfoHasBody(
    List result,
    List<MessageInfo> messagesInfo,
  ) {
    assert(result.length <= MESSAGES_PER_CHUNK);
    assert(result.isNotEmpty);

    final messagesChunk = new List<Message>();

    result.forEach((rawMessage) {
      MessageInfo messageInfo;

      try {
        messageInfo =
            messagesInfo.firstWhere((m) => m.uid == rawMessage["Uid"]);
      } catch (err) {
        throw CustomException("Couldn't find message: ${rawMessage["Uid"]}");
      }

      final displayName = rawMessage["From"] != null
          ? rawMessage["From"]["@Collection"][0]["DisplayName"]
          : "Unknown sender";

      final fromToDisplay = displayName is String && displayName.isNotEmpty
          ? displayName
          : rawMessage["From"]["@Collection"][0]["Email"];

      messageInfo.hasBody = true;
      messagesChunk.add(new Message(
        localId: null,
        uid: rawMessage["Uid"],
        parentUid: messageInfo.parentUid,
        flagsInJson:
            messageInfo.flags == null ? null : json.encode(messageInfo.flags),
        hasThread: messageInfo.hasThread,
        messageId: rawMessage["MessageId"],
        folder: rawMessage["Folder"],
        subject: rawMessage["Subject"],
        size: rawMessage["Size"],
        textSize: rawMessage["TextSize"],
        truncated: rawMessage["Truncated"],
        internalTimeStampInUTC: rawMessage["InternalTimeStampInUTC"],
        receivedOrDateTimeStampInUTC:
            rawMessage["ReceivedOrDateTimeStampInUTC"],
        timeStampInUTC: rawMessage["TimeStampInUTC"],
        toInJson:
            rawMessage["From"] == null ? null : json.encode(rawMessage["From"]),
        fromInJson:
            rawMessage["To"] == null ? null : json.encode(rawMessage["To"]),
        fromToDisplay: fromToDisplay,
        ccInJson:
            rawMessage["Cc"] == null ? null : json.encode(rawMessage["Cc"]),
        bccInJson:
            rawMessage["Bcc"] == null ? null : json.encode(rawMessage["Bcc"]),
        senderInJson: rawMessage["Sender"] == null
            ? null
            : json.encode(rawMessage["Sender"]),
        replyToInJson: rawMessage["ReplyTo"] == null
            ? null
            : json.encode(rawMessage["ReplyTo"]),
//          isSeen: rawMessage["IsSeen"],
//          isFlagged: rawMessage["IsFlagged"],
//          isAnswered: rawMessage["IsAnswered"],
//          isForwarded: rawMessage["IsForwarded"],
        hasAttachments: rawMessage["HasAttachments"],
        hasVcardAttachment: rawMessage["HasVcardAttachment"],
        hasIcalAttachment: rawMessage["HasIcalAttachment"],
        importance: rawMessage["Importance"],
        draftInfoInJson: rawMessage["DraftInfo"] == null
            ? null
            : json.encode(rawMessage["DraftInfo"]),
        sensitivity: rawMessage["Sensitivity"],
        downloadAsEmlUrl: rawMessage["DownloadAsEmlUrl"],
        hash: rawMessage["Hash"],
        headers: rawMessage["Headers"],
        inReplyTo: rawMessage["InReplyTo"],
        references: rawMessage["References"],
        readingConfirmationAddressee:
            rawMessage["ReadingConfirmationAddressee"],
        htmlRaw: rawMessage["HtmlRaw"],
        html: rawMessage["Html"],
        plain: rawMessage["Plain"],
        plainRaw: rawMessage["PlainRaw"],
        rtl: rawMessage["Rtl"],
        extendInJson: rawMessage["Extend"] == null
            ? null
            : json.encode(rawMessage["Extend"]),
        safety: rawMessage["Safety"],
        hasExternals: rawMessage["HasExternals"],
        foundedCIDsInJson: rawMessage["FoundedCIDs"] == null
            ? null
            : json.encode(rawMessage["FoundedCIDs"]),
        foundedContentLocationUrlsInJson:
            rawMessage["FoundedContentLocationUrls"] == null
                ? null
                : json.encode(rawMessage["FoundedContentLocationUrls"]),
        attachmentsInJson: rawMessage["Attachments"] == null
            ? null
            : json.encode(rawMessage["Attachments"]),
        customInJson: rawMessage["Custom"] == null
            ? null
            : json.encode(rawMessage["Custom"]),
      ));
    });

    assert(result.length == messagesChunk.length);

    return messagesChunk;
  }
}

class Sender {
  final String displayName;
  final String email;

  Sender({@required this.displayName, @required this.email});
}
