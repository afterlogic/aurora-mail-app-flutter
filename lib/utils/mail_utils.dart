import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:html/parser.dart';

class MailUtils {
  static List<String> getEmails(String emailsInJson) {
    if (emailsInJson == null) return [];
    final emails = json.decode(emailsInJson);
    if (emails == null) return [];
    final result = emails["@Collection"].map((t) => t["Email"]).toList();
    return new List<String>.from(result);
  }

  static String getDisplayName(String senderInJson) {
    if (senderInJson == null) return "";
    final sender = json.decode(senderInJson);
    if (sender == null) return "";
    final results = sender["@Collection"].map((t) => t["DisplayName"]).toList();
    if (results.isEmpty || results[0] == null || results[0].isEmpty) {
      final results = sender["@Collection"].map((t) => t["Email"]).toList();
      return results[0];
    } else {
      return results[0];
    }
  }

  static String htmlToPlain(String html) {
    final document = parse(html);
    return parse(document.body.text).documentElement.text;
  }

  static String getReplySubject(Message message) {
    final rePrefix = "Re";
    final fwdPrefix = "Fwd";
    final subject = rePrefix + ": " + message.subject;
    final rePrefixes = [rePrefix.toUpperCase()];
    final fwdPrefixes = [fwdPrefix.toUpperCase()];
    final prefixes = rePrefixes.toSet().union(fwdPrefixes.toSet()).join("|");
    String reSubject = "";
    final parts = subject.split(":");
    final resParts = [];
    String subjectEnd = "";

    parts.forEach((part) {
      if (subjectEnd.length == 0) {
        final partUpper = part.toUpperCase().trim();
        bool re = rePrefixes.contains(partUpper);
        bool fwd = fwdPrefixes.contains(partUpper);
        int count = 1;
        final lastResPart =
            (resParts.length > 0) ? resParts[resParts.length - 1] : null;

        if (!re && !fwd) {
          final matches = (new RegExp(
                  r'^\s?(' + prefixes + r')\s?[\[(]([\d]+)[\])]$',
                  caseSensitive: false))
              .allMatches(partUpper)
              .toList();
          if (matches != null &&
              matches.isNotEmpty &&
              matches[0].groupCount == 2) {
            final match = matches[0];
            re = rePrefixes.contains(match.group(1).toUpperCase());
            fwd = fwdPrefixes.contains(match.group(1).toUpperCase());
            count = int.parse(match.group(2));
          }
        }

        if (re) {
          if (lastResPart != null && lastResPart["prefix"] == rePrefix) {
            lastResPart["count"] += count;
          } else {
            resParts.add({"prefix": rePrefix, "count": count});
          }
        } else if (fwd) {
          if (lastResPart && lastResPart["prefix"] == fwdPrefix) {
            lastResPart["count"] += count;
          } else {
            resParts.add({"prefix": fwdPrefix, "count": count});
          }
        } else {
          subjectEnd = part;
        }
      } else {
        subjectEnd += ":" + part;
      }
    });

    resParts.forEach((resPart) {
      if (resPart["count"] == 1) {
        reSubject += resPart["prefix"] + ": ";
      } else {
        reSubject += "${resPart["prefix"]}[${resPart["count"].toString()}]: ";
      }
    });
    reSubject += subjectEnd.trim();

    return reSubject;
  }

  static String getReplyBody(Message message) {
    final baseMessage = htmlToPlain(message.html ?? "");
    final time = DateFormatting.formatDateFromSeconds(
        timestamp: message.timeStampInUTC,
        format: "EEE, MMM d, yyyy 'at' HH:mm");

    final from = getDisplayName(message.fromInJson);

    return "\n\nOn $time, $from wrote:\n$baseMessage";
  }

  static String getForwardSubject(Message message) {
    return "Fwd: ${message.subject}";
  }

  static String getForwardBody(Message message) {
    final baseMessage = htmlToPlain(message.html ?? "");

    // TODO translate
    String forwardMessage = "\n\n---- Original Message ----\n";

    final from = MailUtils.getEmails(message.fromInJson).join(", ");
    final to = MailUtils.getEmails(message.toInJson).join(", ");
    final cc = MailUtils.getEmails(message.ccInJson).join(", ");
    final bcc = MailUtils.getEmails(message.bccInJson).join(", ");

    // TODO translate
    if (from.isNotEmpty) forwardMessage += "From: $from\n";
    // TODO translate
    if (to.isNotEmpty) forwardMessage += "To: $to\n";
    // TODO translate
    if (cc.isNotEmpty) forwardMessage += "CC: $cc\n";
    // TODO translate
    if (bcc.isNotEmpty) forwardMessage += "BCC: $bcc\n";

    final date = DateFormatting.formatDateFromSeconds(
        timestamp: message.timeStampInUTC, format: "EEE, MMM d, yyyy, HH:mm");
    // TODO translate
    forwardMessage += "Sent: $date\n";

    forwardMessage += "Subject: ${message.subject}\n\n";
    return forwardMessage + baseMessage;
  }
}
