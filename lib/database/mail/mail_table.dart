import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
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

  IntColumn get accountEntityId => integer()();

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

  TextColumn get htmlBody => text().withDefault(Constant(""))();

  TextColumn get rawBody => text().withDefault(Constant(""))();

  BoolColumn get rtl => boolean()();

  TextColumn get extendInJson => text()();

  BoolColumn get safety => boolean()();

  BoolColumn get hasExternals => boolean()();

  TextColumn get foundedCIDsInJson => text()();

  TextColumn get foundedContentLocationUrlsInJson => text()();

  TextColumn get attachmentsInJson => text().nullable()();

  TextColumn get customInJson => text()();

  BoolColumn get isHtml => boolean()();

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
    Account account,
  ) {
    assert(result.isNotEmpty);

    final messagesChunk = new List<Message>();

    result.forEach((raw) {
      MessageInfo messageInfo;

      try {
        messageInfo = messagesInfo.firstWhere((m) => m.uid == raw["Uid"]);
      } catch (err) {
        throw Exception("Couldn't find message: ${raw["Uid"]}");
      }

      final displayName = raw["From"] != null
          ? raw["From"]["@Collection"][0]["DisplayName"]
          : "Unknown sender";

      final fromToDisplay = displayName is String && displayName.isNotEmpty
          ? displayName
          : raw["From"]["@Collection"][0]["Email"] as String;

      messageInfo.hasBody = true;
      messagesChunk.add(
        new Message(
          localId: null,
          uid: raw["Uid"] as int,
          userLocalId: userLocalId,
          accountEntityId: account.entityId,
          uniqueUidInFolder: account.entityId.toString() +
              account.localId.toString() +
              raw["Uid"].toString() +
              raw["Folder"].toString(),
          parentUid: messageInfo.parentUid,
          flagsInJson:
              messageInfo.flags == null ? null : json.encode(messageInfo.flags),
          hasThread: messageInfo.hasThread,
          messageId: raw["MessageId"] as String,
          folder: raw["Folder"] as String,
          subject: raw["Subject"] as String,
          size: raw["Size"] as int,
          textSize: raw["TextSize"] as int,
          truncated: raw["Truncated"] as bool,
          internalTimeStampInUTC: raw["InternalTimeStampInUTC"] as int,
          receivedOrDateTimeStampInUTC:
              raw["ReceivedOrDateTimeStampInUTC"] as int,
          timeStampInUTC: raw["TimeStampInUTC"] as int,
          toInJson: raw["From"] == null ? null : json.encode(raw["To"]),
          fromInJson: raw["To"] == null ? null : json.encode(raw["From"]),
          fromToDisplay: fromToDisplay,
          ccInJson: raw["Cc"] == null ? null : json.encode(raw["Cc"]),
          bccInJson: raw["Bcc"] == null ? null : json.encode(raw["Bcc"]),
          senderInJson:
              raw["Sender"] == null ? null : json.encode(raw["Sender"]),
          replyToInJson:
              raw["ReplyTo"] == null ? null : json.encode(raw["ReplyTo"]),
          hasAttachments: raw["HasAttachments"] as bool,
          hasVcardAttachment: raw["HasVcardAttachment"] as bool,
          hasIcalAttachment: raw["HasIcalAttachment"] as bool,
          importance: raw["Importance"] as int,
          draftInfoInJson:
              raw["DraftInfo"] == null ? null : json.encode(raw["DraftInfo"]),
          sensitivity: raw["Sensitivity"] as int,
          downloadAsEmlUrl: raw["DownloadAsEmlUrl"] as String,
          hash: raw["Hash"] as String,
          headers: raw["Headers"] as String,
          inReplyTo: raw["InReplyTo"] as String,
          references: raw["References"] as String,
          readingConfirmationAddressee:
              raw["ReadingConfirmationAddressee"] as String,
          htmlBody: raw["Html"] != null && (raw["Html"] as String).isNotEmpty
              ? raw["Html"] as String
              : raw["Plain"] as String,
          rawBody:
              raw["PlainRaw"] != null && (raw["PlainRaw"] as String).isNotEmpty
                  ? raw["PlainRaw"] as String
                  : MailUtils.htmlToPlain(
                      raw["Html"] as String ?? raw["HtmlRaw"] as String),
          rtl: raw["Rtl"] as bool,
          extendInJson:
              raw["Extend"] == null ? null : json.encode(raw["Extend"]),
          safety: raw["Safety"] as bool,
          hasExternals: raw["HasExternals"] as bool,
          foundedCIDsInJson: raw["FoundedCIDs"] == null
              ? null
              : json.encode(raw["FoundedCIDs"]),
          foundedContentLocationUrlsInJson:
              raw["FoundedContentLocationUrls"] == null
                  ? null
                  : json.encode(raw["FoundedContentLocationUrls"]),
          attachmentsInJson: raw["Attachments"] == null
              ? null
              : json.encode(raw["Attachments"]),
          customInJson:
              raw["Custom"] == null ? null : json.encode(raw["Custom"]),
          isHtml: (raw["Html"] as String)?.isNotEmpty == true,
        ),
      );
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
