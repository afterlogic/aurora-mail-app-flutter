import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/alias_or_identity.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/components/message_webview.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';

class MailUtils {
  MailUtils._();

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

  static AliasOrIdentity findIdentity(
    String infoInJson,
    List<AliasOrIdentity> aliasOrIdentity,
  ) {
    final users = json.decode(infoInJson)["@Collection"] as List;
    for (var user in users) {
      final name = user["DisplayName"] as String;
      final mail = user["Email"] as String;
      final identities = aliasOrIdentity
          .where((item) {
            return item.mail == mail;
          })
          .toList()
          .reversed;
      if (identities.isNotEmpty) {
        final identity = identities.firstWhere(
          (item) {
            return item.name == name;
          },
          orElse: () => null,
        );
        return identity ?? identities.first;
      }
    }
    return null;
  }

  static List<String> getEmails(String emailsInJson,
      {List<String> exceptEmails}) {
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
    final mapped =
        sender["@Collection"].map((t) => t["DisplayName"]) as Iterable;
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
        format: i18n(context, "format_compose_reply_date"));

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
      forwardMessage +=
          i18n(context, "compose_forward_from", {"emails": from}) + "\n";
    if (to.isNotEmpty)
      forwardMessage +=
          i18n(context, "compose_forward_to", {"emails": to}) + "\n";
    if (cc.isNotEmpty)
      forwardMessage +=
          i18n(context, "compose_forward_cc", {"emails": cc}) + "\n";
    if (bcc.isNotEmpty)
      forwardMessage +=
          i18n(context, "compose_forward_bcc", {"emails": bcc}) + "\n";

    final date = DateFormatting.formatDateFromSeconds(
        message.timeStampInUTC, Localizations.localeOf(context).languageCode,
        format: i18n(context, "format_compose_forward_date"));
    forwardMessage +=
        i18n(context, "compose_forward_sent", {"date": date}) + "\n";

    forwardMessage +=
        i18n(context, "compose_forward_subject", {"subject": message.subject}) +
            "\n\n";
    return forwardMessage + baseMessage;
  }

  static String wrapInHtml(
    BuildContext context, {
    @required Message message,
    @required String to,
    @required String date,
    @required String body,
    @required List<MailAttachment> attachments,
    @required bool showLightEmail,
  }) {
    final theme = Theme.of(context);

    final subject = message.subject.isNotEmpty
        ? message.subject
        : i18n(context, "messages_no_subject");

    final paddingBottom = MediaQuery.of(context).padding.bottom;

    final accentColor = _getWebColor(theme.accentColor);
    return "<!doctype html>" +
        """
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
      html, body {
        margin: 0;
        overflow-x: hidden;
        padding: 0;
       
        background: ${_getWebColor(theme.scaffoldBackgroundColor)};
      }
      .attachments, .email-head, .email-content {
        padding: 18px;
      }
      .email-head, .attachments {
        ${_getDarkStyles(context, showLightEmail)}
      }
      body {
        font-family: sans-serif;
        min-height: 100vh;
      }
      .container {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
      }
      .flex {
        display: flex;
        flex-direction: column;
        height: 100%;
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
        -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
        outline: 0;
      }
      .email-content {
        background-color: white;
        word-break: break-all;
        overflow-x: scroll;
        flex: 1;
      }
      .attachments {
        margin-top: 20px;
        padding-bottom: ${paddingBottom}px;
      }
      .attachment {
        display: flex;
        align-items: center;
        margin-bottom: 22px;
      }
      .attachment .leading, .attachment .leading img {
        height: 50px;
        width: 50px;
      }
      .attachment .leading {
        display: flex;
        justify-content: center;
        align-items: center;
        overflow: hidden;
        margin-right: 16px;
        object-fit: cover;
        border-radius: 10px;
      }
    </style>
  </head>
  <body>
    <div class='container'>
      <div class='email-head'>
        <div class="flex row" style="width: calc(100vw - 12px * 2)">
          <div class="flex" style="flex: 1">
            <div style="font-size: 18px">${message.fromToDisplay}</div>
            <div class="disabled-text">$to</div>
            <div class="disabled-text">$date</div>
          </div>
          <div class="flex" style="flex: 0">
            <!-- <a href='https://dummy-crutch.com/#${MessageWebViewActions.SHOW_INFO}' class='icon-btn' style="padding: 0 12px 12px;">${_getInfoIcon(accentColor)}</a> -->
          </div>
        </div>
        <h1 style="font-size: 24px; font-weight: 500; margin-top: 24px">$subject</h1>
        <div style="height: 1px; background-color: black; opacity: 0.05; margin: 24px 0 0"></div>
      </div>
      <div class='email-content'>$body</div>
      ${attachments.isNotEmpty ? '<div style="height: 1px; background-color: black; opacity: 0.05; margin: 24px 0 0"></div>' : ""}
      <div class='attachments'>
        ${attachments.map((a) => _getAttachment(context, a)).toList().join()}
      </div>
    </div>
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

  static String plainToHtml(String text) {
    return text.replaceAll("\n", "<br>").replaceAll("\r\n", "<br />");
  }

  static String _getAttachment(
      BuildContext context, MailAttachment attachment) {
    final theme = Theme.of(context);

    final iconColor = _getWebColor(theme.iconTheme.color);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    String leading;
    if (attachment.thumbnailUrl == null || attachment.thumbnailUrl.isEmpty) {
      leading = "<div class='leading'>${_getAttachmentsIcon(iconColor)}</div>";
    } else {
      final thumbUrl = attachment.thumbnailUrl
          .replaceFirst("mail-attachment/", "mail-attachments-cookieless/");
      leading =
          "<div class='leading'><img src='${"${authBloc.currentUser.hostname}$thumbUrl&AuthToken=${authBloc.currentUser.token}"}' alt=''></div>";
    }
    return """
    <div class='attachment'>
      $leading
      <div class='flex' style='flex: 1'>
        <span>${attachment.fileName}</span>
        <span class='disabled-text'>${filesize(attachment.size)}</span>
      </div>
      <a class='icon-btn' href='https://dummy-crutch.com/#${MessageWebViewActions.DOWNLOAD_ATTACHMENT + attachment.downloadUrl + MessageWebViewActions.DOWNLOAD_ATTACHMENT}'>${_getDownloadIcon(iconColor)}</a>
    </div>
    """;
  }

  static String _getInfoIcon(String color) =>
      """<svg id="information" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">
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
<svg style="width:24px;height:24px" viewBox="0 0 24 24">
    <path fill="$color" d="M16.5,6V17.5A4,4 0 0,1 12.5,21.5A4,4 0 0,1 8.5,17.5V5A2.5,2.5 0 0,1 11,2.5A2.5,2.5 0 0,1 13.5,5V15.5A1,1 0 0,1 12.5,16.5A1,1 0 0,1 11.5,15.5V6H10V15.5A2.5,2.5 0 0,0 12.5,18A2.5,2.5 0 0,0 15,15.5V5A4,4 0 0,0 11,1A4,4 0 0,0 7,5V17.5A5.5,5.5 0 0,0 12.5,23A5.5,5.5 0 0,0 18,17.5V6H16.5Z" />
</svg>
  """;

  static String _getDownloadIcon(String color) =>
      """<svg style="width:24px;height:24px" viewBox="0 0 24 24">
    <path fill="$color" d="M5,20H19V18H5M19,9H15V3H9V9H5L12,16L19,9Z" />
</svg>""";
}
