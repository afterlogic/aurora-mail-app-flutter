import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/components/message_webview.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:html/parser.dart';
import 'package:aurora_mail/utils/extensions/string_extensions.dart';

class MailUtils {

  static String getFriendlyName(Contact contact) {
    if (contact.fullName != null && contact.fullName.isNotEmpty) {
      return '"${contact.fullName}" <${contact.viewEmail}>';
    } else {
      return contact.viewEmail;
    }
  }

  static String displayNameFromFriendly(String friendlyName) {
    final regExp = new RegExp(r'"(.+)" <(.*)>');
    if (regExp.hasMatch(friendlyName)) {
      final matches = regExp.allMatches(friendlyName);
      final firstMatch = matches.elementAt(0);
      return firstMatch.group(1);
    } else {
      return friendlyName;
    }
  }

  static String emailFromFriendly(String friendlyName) {
    final regExp = new RegExp(r'"(.+)" <(.*)>');
    if (regExp.hasMatch(friendlyName)) {
      final matches = regExp.allMatches(friendlyName);
      final firstMatch = matches.elementAt(0);
      return firstMatch.group(2);
    } else {
      return friendlyName;
    }
  }

  static List<String> getEmails(String emailsInJson, {List<String> exceptEmails}) {
    if (emailsInJson == null) return [];
    final emails = json.decode(emailsInJson);
    if (emails == null) return [];
    final result = [];
    emails["@Collection"].forEach((t) {
      final display = t["DisplayName"] as String;
      final email = t["Email"] as String;

      if (exceptEmails != null && exceptEmails.contains(email)) return;

      if (display != null && display.isNotEmpty) {
        result.add('"$display" <$email>');
      } else {
        result.add(email);
      }
    }) as Iterable;

    result.toSet();

    return new List<String>.from(result);
  }

  static String getDisplayName(String senderInJson) {
    if (senderInJson == null) return "";
    final sender = json.decode(senderInJson);
    if (sender == null) return "";
    final mapped = sender["@Collection"].map((t) => t["DisplayName"]) as Iterable;
    final results = List<String>.from(mapped);
    if (results.isEmpty || results[0] == null || results[0].isEmpty) {
      final mapped = sender["@Collection"].map((t) => t["Email"]) as Iterable;
      final results = List<String>.from(mapped);
      return results[0];
    } else {
      return results[0];
    }
  }

  static String htmlToPlain(String html) {
    if (html == null) return "";
    html = html
        .replaceAll("<br>", "\n")
        .replaceAll("<br/>", "\n")
        .replaceAll("<br />", "\r\n");
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
        final lastResPart = (resParts.length > 0) ? resParts[resParts.length - 1] : null;

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
          if (lastResPart != null && lastResPart["prefix"] == fwdPrefix) {
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
        reSubject += (resPart["prefix"] as String) + ": ";
      } else {
        reSubject += "${resPart["prefix"]}[${resPart["count"].toString()}]: ";
      }
    });
    reSubject += subjectEnd.trim();

    return reSubject;
  }

  static String getReplyBody(BuildContext context, Message message) {
    final baseMessage = htmlToPlain(message.htmlBody ?? "");
    final time = DateFormatting.formatDateFromSeconds(
        message.timeStampInUTC, Localizations.localeOf(context).languageCode,
        format: i18n(context, "compose_reply_date_format"));

    final from = getDisplayName(message.fromInJson);

    return "\n\n${i18n(context, "compose_reply_body_title", {
      "time": time,
      "from": from
    })}\n$baseMessage";
  }

  static String getForwardSubject(Message message) {
    return "Fwd: ${message.subject}";
  }

  static String getForwardBody(BuildContext context, Message message) {
    final baseMessage = htmlToPlain(message.htmlBody ?? "");

    String forwardMessage =
        "\n\n${i18n(context, "compose_forward_body_original_message")}\n";

    final from = MailUtils.getEmails(message.fromInJson).join(", ");
    final to = MailUtils.getEmails(message.toInJson).join(", ");
    final cc = MailUtils.getEmails(message.ccInJson).join(", ");
    final bcc = MailUtils.getEmails(message.bccInJson).join(", ");

    if (from.isNotEmpty)
      forwardMessage += i18n(context, "compose_forward_from", {"emails": from}) + "\n";
    if (to.isNotEmpty)
      forwardMessage += i18n(context, "compose_forward_to", {"emails": to}) + "\n";
    if (cc.isNotEmpty)
      forwardMessage += i18n(context, "compose_forward_cc", {"emails": cc}) + "\n";
    if (bcc.isNotEmpty)
      forwardMessage += i18n(context, "compose_forward_bcc", {"emails": bcc}) + "\n";

    final date = DateFormatting.formatDateFromSeconds(
        message.timeStampInUTC, Localizations.localeOf(context).languageCode,
        format: i18n(context, "compose_forward_date_format"));
    forwardMessage +=
        i18n(context, "compose_forward_sent", {"date": date}) + "\n";

    forwardMessage +=
        i18n(context, "compose_forward_subject", {"subject": message.subject}) +
            "\n\n";
    return forwardMessage + baseMessage;
  }

  static String wrapInHtml(BuildContext context, {
    @required Message message,
    @required String to,
    @required String date,
    @required String body,
    @required bool showAttachmentsBtn,
    @required bool showLightEmail,
  }) {
    final subject = message.subject.isNotEmpty ? message.subject : i18n(context, "messages_no_subject");
    final theme = Theme.of(context);

    final accentColor = _getWebColor(theme.accentColor);
    return "<!doctype html>" + """
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
      html, body {
        margin: 0;
        padding: 0;
      }
      .email-head {
        ${_getDarkStyles(context, showLightEmail)}
        padding: 18px;
      }
      body {
        overflow-x: hidden;
        font-family: sans-serif;
      }
      .flex {
        display: flex;
        flex-direction: column;
      }
      .row {
        flex-direction: row;
      }
      .disabled-text {
        opacity: 0.3;
        font-size: 14px; 
        margin-top: 7px;
      }
      .icon-btn {
        padding: 0 12px 12px;
        -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
        outline: 0;
      }
      .email-content {
        padding: 18px;
        word-break: break-all;
        overflow-x: scroll;
      }
    </style>
  </head>
  <body>
    <div class='email-head'>
      <div class="flex row" style="width: calc(100vw - 12px * 2)">
        <div class="flex" style="flex: 1">
          <div style="font-size: 18px">${message.fromToDisplay}</div>
          <div class="disabled-text">$to</div>
          <div class="disabled-text">$date</div>
        </div>
        <div class="flex" style="flex: 0">
          <!-- <a href='https://dummy-crutch.com/#${MessageWebViewActions.SHOW_INFO}' class='icon-btn'>${_getInfoIcon(accentColor)}</a> -->
          <a href='https://dummy-crutch.com/#${MessageWebViewActions.SHOW_ATTACHMENTS}' class='icon-btn' style='${showAttachmentsBtn != true ? "display: none" : ""}'>
            ${_getAttachmentsIcon(accentColor)}
          </a>
        </div>
      </div>
      <h1 style="font-size: 24px; font-weight: 500; margin-top: 24px">$subject</h1>
      <div style="height: 1px; background-color: black; opacity: 0.05; margin: 24px 0"></div>
    </div>
    <div class='email-content'>$body</div>
  </body>
</html>
    """;
  }

  static String _getDarkStyles(BuildContext context, bool showLightEmail) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = _getWebColor(theme.scaffoldBackgroundColor);
    final textColor = _getWebColor(theme.textTheme.body1.color);

    if (isDark == true && showLightEmail == false) {
      return """
        background: $backgroundColor;
        background-color: $backgroundColor;
        color: $textColor;
      """;
    } else {
      return "";
    }
  }

  static String _getWebColor(Color colorObj) {
    final base = colorObj.toString();
    final color = base.substring(base.length - 7, base.length - 1);
    final opacity = base.substring(base.length - 9, base.length - 7);
    return "#$color$opacity";
  }

  static String _getInfoIcon(String color) => """<svg id="information" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">
  <g id="Group_32" data-name="Group 32">
  <g id="Group_31" data-name="Group 31">
  <path id="Path_53" data-name="Path 53" d="M10,0A10,10,0,1,0,20,10,9.988,9.988,0,0,0,10,0Zm0,18.34A8.34,8.34,0,1,1,18.34,10,8.354,8.354,0,0,1,10,18.34Z" fill="$color"/>
  </g>
  </g>
  <g id="Group_34" data-name="Group 34" transform="translate(9.135 7.761)">
  <g id="Group_33" data-name="Group 33">
  <path id="Path_54" data-name="Path 54" d="M231.307,192a.887.887,0,0,0-.907.859v6.961a.91.91,0,0,0,1.814.043v-7A.887.887,0,0,0,231.307,192Z" transform="translate(-230.4 -192)" fill="$color"/>
  </g>
  </g>
  <circle id="Ellipse_17" data-name="Ellipse 17" cx="1" cy="1" r="1" transform="translate(8.989 3.989)" fill="$color"/>
  </svg>""";

  static String _getAttachmentsIcon(String color) => """
  <svg id="paperclip" xmlns="http://www.w3.org/2000/svg" width="18.126" height="20" viewBox="0 0 18.126 20">
  <path id="Path_30" data-name="Path 30" d="M24.4,20a4.129,4.129,0,0,1-2.92-7.049l9.264-9.264a2.8,2.8,0,1,1,3.965,3.965l-6.814,6.814a.693.693,0,0,1-.981-.981l6.814-6.815a1.417,1.417,0,1,0-2-2l-9.264,9.264a2.742,2.742,0,0,0,3.878,3.878l9.482-9.482a4.068,4.068,0,0,0-5.753-5.753L23.032,9.607a.693.693,0,0,1-.981-.981L29.084,1.6A5.454,5.454,0,1,1,36.8,9.309l-9.482,9.482A4.1,4.1,0,0,1,24.4,20Z" transform="translate(-20.269 0)" fill="$color"/>
</svg>
  """;
}
