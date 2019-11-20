import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  static String getReplyBody(BuildContext context, Message message) {
    final baseMessage = htmlToPlain(message.html ?? "");
    final time = DateFormatting.formatDateFromSeconds(
        message.timeStampInUTC, Localizations.localeOf(context).languageCode,
        format: S.of(context).compose_reply_date_format);

    final from = getDisplayName(message.fromInJson);

    return "\n\n${S.of(context).compose_reply_body_title(time, from)}\n$baseMessage";
  }

  static String getForwardSubject(Message message) {
    return "Fwd: ${message.subject}";
  }

  static String getForwardBody(BuildContext context, Message message) {
    final baseMessage = htmlToPlain(message.html ?? "");

    String forwardMessage =
        "\n\n${S.of(context).compose_forward_body_original_message}\n";

    final from = MailUtils.getEmails(message.fromInJson).join(", ");
    final to = MailUtils.getEmails(message.toInJson).join(", ");
    final cc = MailUtils.getEmails(message.ccInJson).join(", ");
    final bcc = MailUtils.getEmails(message.bccInJson).join(", ");

    if (from.isNotEmpty)
      forwardMessage += S.of(context).compose_forward_from(from) + "\n";
    if (to.isNotEmpty)
      forwardMessage += S.of(context).compose_forward_to(to) + "\n";
    if (cc.isNotEmpty)
      forwardMessage += S.of(context).compose_forward_cc(cc) + "\n";
    if (bcc.isNotEmpty)
      forwardMessage += S.of(context).compose_forward_bcc(bcc) + "\n";

    final date = DateFormatting.formatDateFromSeconds(
        message.timeStampInUTC, Localizations.localeOf(context).languageCode,
        format: S.of(context).compose_forward_date_format);
    forwardMessage += S.of(context).compose_forward_sent(date) + "\n";

    forwardMessage +=
        S.of(context).compose_forward_subject(message.subject) + "\n\n";
    return forwardMessage + baseMessage;
  }

  static String wrapInHtml(BuildContext context, String body) {
    return """
    <!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
    html{
      width: 100vw;
    }
    body {
      width: 100vw;
      overflow-x: hidden;
      background-color: ${_getWebColor(Colors.grey[50])}
    }
    </style>
  </head>
  <body>
    $body
  </body>
</html>
    """;
  }

  static String _getWebColor(Color colorObj) {
    final base = colorObj.toString();
    final color = base.substring(base.length - 7, base.length - 1);
    final opacity = base.substring(base.length - 9, base.length - 7);
    return "#$color$opacity";
  }
}
