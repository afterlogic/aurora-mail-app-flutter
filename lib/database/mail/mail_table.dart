import 'dart:convert';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/widgets.dart' as widgets;
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

  IntColumn get uid => integer()();

  IntColumn get userLocalId => integer()();

  // in order to prevent inserting duplicate messages in the same folder
  // since uids are unique only inside a particular folder
  TextColumn get uniqueUidInFolder => text().customConstraint("UNIQUE")();

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

//  TextColumn get htmlRaw => text().nullable()();

  TextColumn get html => text().nullable()();

  TextColumn get plain => text()();

//  TextColumn get plainRaw => text()();

  BoolColumn get rtl => boolean()();

  TextColumn get extendInJson => text()();

  BoolColumn get safety => boolean()();

  BoolColumn get hasExternals => boolean()();

  TextColumn get foundedCIDsInJson => text()();

  TextColumn get foundedContentLocationUrlsInJson => text()();

  TextColumn get attachmentsInJson => text().nullable()();

  TextColumn get customInJson => text()();

  static List getToForDisplay(
      widgets.BuildContext context, String toInJson, String currentUserEmail) {
    final toDecoded = json.decode(toInJson);
    if (toDecoded == null) return [];
    final collection = toDecoded["@Collection"] as List;
    if (collection == null || collection.isEmpty) return [];
    return collection.map((to) {
      if (to["Email"] == currentUserEmail) {
        return i18n(context, "messages_to_me");
      } else {
        final displayName = to["DisplayName"] as String;
        return displayName.isNotEmpty ? to["DisplayName"] : to["Email"];
      }
    }).toList();
  }

  static List<MessageFlags> getFlags(String flagsInJson) {
    final flags = json.decode(flagsInJson) as Iterable;
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
      final senders = decoded["@Collection"].map((rawSender) {
        return new Sender(
          displayName: rawSender["DisplayName"] as String,
          email: rawSender["Email"] as String,
        );
      }) as Iterable;
      return List<Sender>.from(senders);
    } else {
      throw Exception("Could not get sender");
    }
  }

  static List<Message> getMessageObjFromServerAndUpdateInfoHasBody(
    List result,
    List<MessageInfo> messagesInfo,
    int userLocalId,
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
        throw Exception("Couldn't find message: ${rawMessage["Uid"]}");
      }

      final displayName = rawMessage["From"] != null
          ? rawMessage["From"]["@Collection"][0]["DisplayName"]
          : "Unknown sender";

      final fromToDisplay = displayName is String && displayName.isNotEmpty
          ? displayName
          : rawMessage["From"]["@Collection"][0]["Email"] as String;

      messageInfo.hasBody = true;
      messagesChunk.add(new Message(
        localId: null,
        uid: rawMessage["Uid"] as int,
        userLocalId: userLocalId,
        uniqueUidInFolder: rawMessage["Uid"].toString() + rawMessage["Folder"].toString(),
        parentUid: messageInfo.parentUid,
        flagsInJson:
            messageInfo.flags == null ? null : json.encode(messageInfo.flags),
        hasThread: messageInfo.hasThread,
        messageId: rawMessage["MessageId"] as String,
        folder: rawMessage["Folder"] as String,
        subject: rawMessage["Subject"] as String,
        size: rawMessage["Size"] as int,
        textSize: rawMessage["TextSize"] as int,
        truncated: rawMessage["Truncated"] as bool,
        internalTimeStampInUTC: rawMessage["InternalTimeStampInUTC"] as int,
        receivedOrDateTimeStampInUTC:
            rawMessage["ReceivedOrDateTimeStampInUTC"] as int,
        timeStampInUTC: rawMessage["TimeStampInUTC"] as int,
        toInJson:
            rawMessage["From"] == null ? null : json.encode(rawMessage["To"]),
        fromInJson:
            rawMessage["To"] == null ? null : json.encode(rawMessage["From"]),
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
        hasAttachments: rawMessage["HasAttachments"] as bool,
        hasVcardAttachment: rawMessage["HasVcardAttachment"] as bool,
        hasIcalAttachment: rawMessage["HasIcalAttachment"] as bool,
        importance: rawMessage["Importance"] as int,
        draftInfoInJson: rawMessage["DraftInfo"] == null
            ? null
            : json.encode(rawMessage["DraftInfo"]),
        sensitivity: rawMessage["Sensitivity"] as int,
        downloadAsEmlUrl: rawMessage["DownloadAsEmlUrl"] as String,
        hash: rawMessage["Hash"] as String,
        headers: rawMessage["Headers"] as String,
        inReplyTo: rawMessage["InReplyTo"] as String,
        references: rawMessage["References"] as String,
        readingConfirmationAddressee:
            rawMessage["ReadingConfirmationAddressee"] as String,
//        htmlRaw: rawMessage["HtmlRaw"],
        html: rawMessage["Html"] as String,
        plain: rawMessage["PlainRaw"] as String,
//        plainRaw: rawMessage["PlainRaw"],
        rtl: rawMessage["Rtl"] as bool,
        extendInJson: rawMessage["Extend"] == null
            ? null
            : json.encode(rawMessage["Extend"]),
        safety: rawMessage["Safety"] as bool,
        hasExternals: rawMessage["HasExternals"] as bool,
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
