import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/res/str/s.dart';
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

const SEARCH_SEPARATOR = "/^_^/";

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

  TextColumn get messageId => text().nullable()();

  TextColumn get folder => text()();

  TextColumn get flagsInJson => text()();

  BoolColumn get hasThread => boolean()();

  TextColumn get subject => text().nullable()();

  IntColumn get size => integer().nullable()();

  IntColumn get textSize => integer().nullable()();

  BoolColumn get truncated => boolean().nullable()();

  IntColumn get internalTimeStampInUTC => integer().nullable()();

  IntColumn get receivedOrDateTimeStampInUTC => integer().nullable()();

  IntColumn get timeStampInUTC => integer().nullable()();

  TextColumn get toToDisplay => text().nullable()();

  TextColumn get toInJson => text().nullable()();

  TextColumn get fromInJson => text().nullable()();

  TextColumn get fromToDisplay => text().nullable()();

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

  BoolColumn get hasAttachments => boolean().nullable()();

  BoolColumn get hasVcardAttachment => boolean().nullable()();

  BoolColumn get hasIcalAttachment => boolean().nullable()();

  IntColumn get importance => integer().nullable()();

  TextColumn get draftInfoInJson => text().nullable()();

  IntColumn get sensitivity => integer().nullable()();

  TextColumn get downloadAsEmlUrl => text().nullable()();

  TextColumn get hash => text().nullable()();

  TextColumn get headers => text().nullable()();

  TextColumn get inReplyTo => text().nullable()();

  TextColumn get references => text().nullable().named("message_references")();

  TextColumn get readingConfirmationAddressee => text().nullable()();

//  TextColumn get htmlRaw => text().nullable()();

  TextColumn get htmlBody => text().withDefault(Constant(""))();

  TextColumn get rawBody => text().withDefault(Constant(""))();

  TextColumn get bodyForSearch => text().nullable().withDefault(Constant(""))();

  BoolColumn get rtl => boolean().nullable()();

  TextColumn get extendInJson => text().nullable()();

  BoolColumn get safety => boolean().nullable()();

  BoolColumn get hasExternals => boolean().nullable()();

  TextColumn get foundedCIDsInJson => text().nullable()();

  TextColumn get foundedContentLocationUrlsInJson => text().nullable()();

  TextColumn get attachmentsInJson => text().nullable()();

  TextColumn get toForSearch => text().nullable()();

  TextColumn get fromForSearch => text().nullable()();

  TextColumn get ccForSearch => text().nullable()();

  TextColumn get bccForSearch => text().nullable()();

  TextColumn get attachmentsForSearch => text().nullable()();

  TextColumn get customInJson => text().nullable()();

  BoolColumn get isHtml => boolean().nullable()();

  BoolColumn get hasBody => boolean()();

  static List getToForDisplay(
    widgets.BuildContext context,
    String toInJson,
    String currentUserEmail,
  ) {
    if (toInJson == null) return [];
    final toDecoded = json.decode(toInJson);
    if (toDecoded == null) return [];
    final collection = toDecoded["@Collection"] as List;
    if (collection == null || collection.isEmpty) return [];
    return collection.map((to) {
      if (to["Email"] == currentUserEmail) {
        return i18n(context, S.messages_to_me);
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
    List<Message> messagesInfo,
    int userLocalId,
    Account account,
  ) {
    assert(result.isNotEmpty);

    final messagesChunk = new List<Message>();
    final messageInfoMap = Map.fromEntries(
        messagesInfo.map((item) => MapEntry(item.uid, item)).toList());
    result.forEach((raw) {
      Message messageInfo;

      try {
        messageInfo = messageInfoMap[raw["Uid"]];
      } catch (err) {
        throw Exception("Couldn't find message: ${raw["Uid"]}");
      }
      final toToDisplay = (raw["To"] != null &&
              raw["To"]["@Collection"]?.isNotEmpty == true)
          ? raw["To"]["@Collection"]
              ?.map(
                (item) => item["DisplayName"]?.isNotEmpty == true
                    ? item["DisplayName"]
                    : item["Email"],
              )
              ?.join(", ") as String
          : (raw["CC"] != null && raw["CC"]["@Collection"]?.isNotEmpty == true)
              ? raw["CC"]["@Collection"]
                  ?.map(
                    (item) => item["DisplayName"]?.isNotEmpty == true
                        ? item["DisplayName"]
                        : item["Email"],
                  )
                  ?.join(", ") as String
              : "messages_unknown_recipient";
      final displayName = raw["From"] != null
          ? raw["From"]["@Collection"][0]["DisplayName"]
          : "messages_unknown_sender";

      final fromToDisplay = displayName is String && displayName.isNotEmpty
          ? displayName
          : raw["From"]["@Collection"][0]["Email"] as String;

      messagesChunk.add(new Message(
        localId: messageInfo.localId,
        uid: messageInfo.uid,
        userLocalId: userLocalId,
        accountEntityId: account.entityId,
        uniqueUidInFolder: messageInfo.uniqueUidInFolder,
        parentUid: messageInfo.parentUid,
        flagsInJson: messageInfo.flagsInJson,
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
        toToDisplay: toToDisplay,
        fromToDisplay: fromToDisplay,
        toInJson: _encode(raw["To"]),
        fromInJson: _encode(raw["From"]),
        ccInJson: _encode(raw["Cc"]),
        bccInJson: _encode(raw["Bcc"]),
        toForSearch: _getEmailsForSearch(raw["To"] as Map),
        fromForSearch: _getEmailsForSearch(raw["From"] as Map),
        ccForSearch: _getEmailsForSearch(raw["Cc"] as Map),
        bccForSearch: _getEmailsForSearch(raw["Bcc"] as Map),
        senderInJson: _encode(raw["Sender"]),
        replyToInJson: _encode(raw["ReplyTo"]),
        hasAttachments: raw["HasAttachments"] as bool,
        hasVcardAttachment: raw["HasVcardAttachment"] as bool,
        hasIcalAttachment: raw["HasIcalAttachment"] as bool,
        importance: raw["Importance"] as int,
        draftInfoInJson: _encode(raw["DraftInfo"]),
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
                    (raw["HtmlRaw"] ?? raw["Html"] ?? "") as String),
        bodyForSearch: _htmlToTextSearch(
            ((((raw["HtmlRaw"] ?? raw["Html"]) as String)?.isNotEmpty == true
                    ? raw["Html"]
                    : raw["PlainRaw"]) ??
                "") as String),
        rtl: raw["Rtl"] as bool,
        extendInJson: _encode(raw["Extend"]),
        safety: raw["Safety"] as bool,
        hasExternals: raw["HasExternals"] as bool,
        foundedCIDsInJson: _encode(raw["FoundedCIDs"]),
        foundedContentLocationUrlsInJson:
            _encode(raw["FoundedContentLocationUrls"]),
        attachmentsInJson: _encode(raw["Attachments"]),
        attachmentsForSearch:
            _getAttachmentsForSearch(raw["Attachments"] as Map),
        customInJson: _encode(raw["Custom"]),
        isHtml: (raw["Html"] as String)?.isNotEmpty == true,
        hasBody: true,
      ));
    });

    assert(result.length == messagesChunk.length);

    return messagesChunk;
  }

  static String _htmlToTextSearch(String html) {
    return html
        .replaceAllMapped(
            RegExp("(([^>]{1})<div>)"), (math) => '${math.group(2)} ')
        .replaceAllMapped(RegExp('(<a [^>]*href="([^"]*?)"[^>]*>(.*?)<\/a>)'),
            (math) => '${math.group(1)} (${math.group(2)})')
        .replaceAll(RegExp("(<style[^>]*>[^<]*<\/style>)"), ' ')
        .replaceAll(RegExp("<br *\/{0,1}>"), '\n')
        .replaceAll(RegExp("<[^>]*>"), '')
        .replaceAll("<\/p>", ' ')
        .replaceAll("<\/div>", ' ')
        .replaceAll("&nbsp;", ' ')
        .replaceAll("&lt;", '<')
        .replaceAll("&gt;", '>')
        .replaceAll("&amp;", '&')
        .replaceAll("&quot;", '"')
        .replaceAll("\s+", ' ');
  }

  static String _encode(dynamic raw) {
    if (raw == null) return null;
    return json.encode(raw);
  }

  static String _getEmailsForSearch(Map emails) {
    if (emails == null) return "";
    final result = [];
    emails["@Collection"].forEach((t) {
      final display = t["DisplayName"] as String;
      final email = t["Email"] as String;

      if (display != null && display.isNotEmpty) {
        result.add('"$display" <$email>');
      } else {
        result.add(email);
      }
    }) as Iterable;

    result.toSet();

    return result.join(SEARCH_SEPARATOR);
  }

  static String _getAttachmentsForSearch(Map attachments) {
    if (attachments == null) return "";
    final names =
        (attachments["@Collection"] as List).map((a) => a["FileName"]);
    return names.join(SEARCH_SEPARATOR);
  }
}

class Sender {
  final String displayName;
  final String email;

  Sender({@required this.displayName, @required this.email});
}
