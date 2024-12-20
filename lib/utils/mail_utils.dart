//@dart=2.9
import 'dart:convert';

import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/models/alias_or_identity.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/components/message_webview.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:aurora_mail/utils/extensions/colors_extensions.dart';
import 'package:collection/collection.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class MailUtils {
  MailUtils._();

  static Map<String, dynamic> getExtendFromMessageByObjectTypeName(
      List<String> types, Message m) {
    if (m.extendInJson == null) return null;
    try {
      final decodedList = jsonDecode(m.extendInJson) as List;
      final extended =
          decodedList.firstWhereOrNull((e) => types.contains(e["@Object"]));
      return extended as Map<String, dynamic>;
    } catch (e, s) {
      return null;
    }
  }

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

  static String extractFirstContent(String htmlString) {
    if (htmlString == null || htmlString.isEmpty) return '';
    try {
      Document document = parse(htmlString);
      String findFirstText(Node node) {
        if (node == null) return null;
        if (node.nodeType == Node.TEXT_NODE && node.text.trim().isNotEmpty) {
          return node.text.trim();
        }

        for (final child in node.nodes) {
          var result = findFirstText(child);
          if (result != null) {
            return result;
          }
        }
        return null;
      }

      return findFirstText(document.body) ?? '';
    } catch (e, st) {
      logger.log(
        'extractFirstContent for note error: $e',
      );
      return '';
    }
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
    final baseMessage = message.htmlBody;
    final time = DateFormatting.formatDateFromSeconds(
        message.timeStampInUTC, Localizations.localeOf(context).languageCode,
        format: S.of(context).format_compose_reply_date);

    final from = getDisplayName(message.fromInJson);

    return "<br><br><br>${S.of(context).compose_reply_body_title(time, from)}<br><blockquote>$baseMessage</blockquote>";
  }

  static String getForwardSubject(Message message) {
    return "Fwd: ${message.subject}";
  }

  static String getForwardBody(BuildContext context, Message message) {
    final baseMessage = message.htmlBody ?? "";

    String forwardMessage =
        "<br><br>${S.of(context).compose_forward_body_original_message}<br>";

    final from = MailUtils.getEmails(message.fromInJson).join(", ");
    final to = MailUtils.getEmails(message.toInJson).join(", ");
    final cc = MailUtils.getEmails(message.ccInJson).join(", ");
    final bcc = MailUtils.getEmails(message.bccInJson).join(", ");

    if (from.isNotEmpty)
      forwardMessage += S.of(context).compose_forward_from(from) + "<br>";
    if (to.isNotEmpty)
      forwardMessage += S.of(context).compose_forward_to(to) + "<br>";
    if (cc.isNotEmpty)
      forwardMessage += S.of(context).compose_forward_cc(cc) + "<br>";
    if (bcc.isNotEmpty)
      forwardMessage += S.of(context).compose_forward_bcc(bcc) + "<br>";

    final date = DateFormatting.formatDateFromSeconds(
        message.timeStampInUTC, Localizations.localeOf(context).languageCode,
        format: S.of(context).format_compose_forward_date);
    forwardMessage += S.of(context).compose_forward_sent(date) + "<br>";

    forwardMessage +=
        S.of(context).compose_forward_subject(message.subject) + "<br><br>";
    return forwardMessage + baseMessage;
  }

  static String wrapInHtmlEditor(
      BuildContext context, String text, bool isHtml, bool removeForcedHeight) {
    final theme = Theme.of(context);
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
        padding: 10px;
        color:${_getWebColor(DefaultTextStyle.of(context).style.color)};
        background: ${_getWebColor(theme.scaffoldBackgroundColor)};
      }
      .primary-color {
        color: ${_getWebColor(theme.primaryColor)};
      }
      body {
        font-family: sans-serif;
        ${removeForcedHeight ? '' : 'min-height: 100vh;'}
      }
      .container {
        ${removeForcedHeight ? '' : 'min-height: 100vh;'}
        display: flex;
        flex-direction: column;
      }
      .flex {
        display: flex;
        flex-direction: column;
        height: 100%;
      }
      .row {
        display: flex;
        flex-direction: row;
        padding: 5px 0px;
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
        word-break: break-word;
        overflow-x: scroll;
        flex: 1;
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
      .folder_label {
       display: flex;
       border-radius: 15px;
       background: #609;
      }
      .toggle {
        text-decoration: none;
      }
      .toggle-content {
      	display: none;
      }
      .toggle-content.is-visible {
        padding: 16px;
        background: ${Color.lerp(
          theme.scaffoldBackgroundColor,
          theme.brightness == Brightness.dark ? Colors.white : Colors.black,
          0.1,
        ).toHex()};
      	display: block;
      }
      .details-description {
        min-width: 50px; 
        color: ${(theme.brightness == Brightness.dark ? Colors.white : Colors.black).toHex()};
        opacity: 0.4;
      }
      .details-value {
        color: ${(theme.brightness == Brightness.dark ? Colors.white : Colors.black).toHex()};
      }
      blockquote,
      .blockquote {
        border-left: solid 2px #000000;
        margin: 4px 2px;
        padding-left: 6px;
      }
    </style>
    <script>      
    window.getBodyContent = function () {
    return document.body.innerHTML;
    }
    window.setBodyContent = function (content) {
      document.body.innerHTML=content;
    }
    window.setPlain = function () {
     document.body.style = "white-space: pre;";
    }
    
    window.setHtml = function () {
        document.body.style = "";
    }
    </script>
  </head>
  <body contenteditable="true" ${!isHtml ? "style=\"white-space: pre;\"" : ""}>
    $text
  </body>
</html>
    
    """;
  }

  static String wrapInHtml(
    BuildContext context, {
    @required Message message,
    @required String to,
    @required String date,
    @required String body,
    @required List<MailAttachment> attachments,
    @required bool showLightEmail,
    ViewCalendar initCalendar,
    Map<String, dynamic> extendedEvent,
    bool isStarred,
  }) {
    final theme = Theme.of(context);

    final subject = message.subject.isNotEmpty
        ? message.subject
        : S.of(context).messages_no_subject;
    final shortDate = DateFormatting.getShortMessageDate(
      timestamp: message.timeStampInUTC,
      locale: Localizations.localeOf(context).languageCode,
      yesterdayWord: S.of(context).label_message_yesterday,
      is24: true,
    );
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    List<String> formatContact(String json) {
      if (json == null) return [];
      return (jsonDecode(json)["@Collection"] as List)
          .map((item) => (item["DisplayName"]?.isNotEmpty == true
              ? ("${item["DisplayName"]} ${item["Email"]}")
              : item["Email"]) as String)
          .toList();
    }

    final from = formatContact(message.fromInJson).join("<br>");
    final cc = formatContact(message.ccInJson).join("<br>");
    final to = formatContact(message.toInJson).join("<br>");
    var toPrimary = (formatContact(message.toInJson)
          ..addAll(formatContact(message.ccInJson)))
        .toSet()
        .join("<br>");
    if (toPrimary.isEmpty) {
      toPrimary = S.of(context).messages_no_receivers;
    }
//    cc ??= "";

    final accentColor = _getWebColor(theme.primaryColor);
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
      .primary-color {
        color:${accentColor};
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
        display: flex;
        flex-direction: row;
        padding: 5px 0px;
        align-items: center;
      }
      .row.fluid {
          padding-left: 100px;
      }
      .row.fluid .label {
          margin-left: -100px;
      }
      .row.fluid .value {
          width: 99%;
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
        word-break: break-word;
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
      .folder_label {
       display: flex;
       border-radius: 15px;
       background: #609;
      }
      .toggle {
        text-decoration: none;
      }
      .toggle-content {
      	display: none;
      }
      .toggle-content.is-visible {
        padding: 16px;
        background: ${Color.lerp(
          theme.scaffoldBackgroundColor,
          theme.brightness == Brightness.dark ? Colors.white : Colors.black,
          0.1,
        ).toHex()};
      	display: block;
      }
      .details-description {
        min-width: 50px; 
        color: ${(theme.brightness == Brightness.dark ? Colors.white : Colors.black).toHex()};
        opacity: 0.4;
      }
      .details-value {
        color: ${(theme.brightness == Brightness.dark ? Colors.white : Colors.black).toHex()};
      }
      blockquote,
      .blockquote {
        border-left: solid 2px #000000;
        margin: 4px 2px;
        padding-left: 6px;
      }
      .unselectable {
        user-select: none;
      }
      .selectable {
        user-select: text;
      }
      .appointment {
        background: ${(theme.brightness == Brightness.dark ? '#05697a' : '#dff6eb')};
        border-bottom: 1px solid ${(theme.brightness == Brightness.dark ? '#084853' : '#b7ebd2')};
        padding: 15px;
      }
      .appointment button {
        margin-right: 5px;
        border-radius: 4px;
        display: inline-block;
        padding: 5px 12px;
        text-align: center;
        background: #43d0bf;
        border: 1px solid #2db3a3;
        color: #ffffff;
        font-size: 16px;
        text-shadow: 0px 1px 0px rgba(0, 0, 0, 0.3);
      }
      .appointment .label {
        vertical-align: bottom;
        display: inline-block;
        width: 100px;
        color: ${(theme.brightness == Brightness.dark ? '#bbb' : '#888')};
      }
      .appointment .value {
        color: ${(theme.brightness == Brightness.dark ? Colors.white : Colors.black).toHex()};
      }
      .appointment .custom-dropdown {
          display: flex;
          align-items: center;
          justify-content: space-between;
          width: auto;
          max-width: 200px;
          padding: 8px;
          border: 1px solid #ccc;
          border-radius: 4px;
          font-family: Arial, sans-serif;
          font-size: 14px;
          background-color: #f8f8f8;
          cursor: pointer;
      }
      .appointment .custom-dropdown .dropdown-label {
          margin-right: 10px;
          color: #000;
      }
      .appointment .custom-dropdown .dropdown-arrow {
          width: 0;
          height: 0;
          border-left: 5px solid transparent;
          border-right: 5px solid transparent;
          border-top: 5px solid #000;
      }
    </style>
    <script>      
        document.addEventListener('DOMContentLoaded', function () {
          document.getElementById('stared-btn').addEventListener('click', function (event) {
                let elem=event.target
                if (elem.classList.contains("is-starred")) {
                    elem.innerHTML = "&#9734;"
                    elem.classList.remove("is-starred");
                       elem.href="${MessageWebViewActions.ACTION + MessageWebViewActions.SET_NOT_STARRED}"
                } else {
                    elem.innerHTML = "&#9733;" 
                    elem.classList.add("is-starred");
                    elem.href="${MessageWebViewActions.ACTION + MessageWebViewActions.SET_STARRED}"
                }
            }, false);
            document.getElementById('info-btn').addEventListener('click', function (event) {
                event.preventDefault();
                let elem=event.target
                if (elem.classList.contains("is-visible")) {
                    elem.innerHTML ="${S.of(context).btn_show_details}";
                } else {
                    elem.innerHTML ="${S.of(context).btn_hide_details}";
                }
                document.getElementById('info').classList.toggle('is-visible');                
                elem.classList.toggle('is-visible');
            }, false);
        });
        
        const getSelectedCalendarId = () => document.querySelector('#calendars_select').value;
       
        function setSelectedCalendar(data) {
            document.getElementById('custom-dropdown-value').innerText = data;
        }
       
        function handleDropdownClick() {
            return window.${ExpandedEventWebViewActions.CHANNEL}.postMessage('${ExpandedEventWebViewActions.DROPDOWN_CLICKED}');
        }
      
        function acceptEvent(){
          return window.${ExpandedEventWebViewActions.CHANNEL}.postMessage('${ExpandedEventWebViewActions.ACCEPT}');
        }
       
        function declineEvent(){
          return window.${ExpandedEventWebViewActions.CHANNEL}.postMessage('${ExpandedEventWebViewActions.DECLINE}');
        }
       
        function tentativeEvent(){
          return window.${ExpandedEventWebViewActions.CHANNEL}.postMessage('${ExpandedEventWebViewActions.TENTATIVE}');
        }
        
        function downloadAttachment(str){
          return window.${MessageWebViewActions.WEB_VIEW_JS_CHANNEL}.postMessage('${MessageWebViewActions.DOWNLOAD_ATTACHMENT}'+str);
        }
    </script>
  </head>
  <body class="unselectable">
    <div class="container">
      <div class="email-head">
        <div class="flex" style="width: calc(100vw - 12px * 2)">
          <div class="flex" style="flex: 1">
            <div style="font-size: 18px" class="selectable">${message.fromToDisplay}</div>
            <div class="selectable disabled-text">$toPrimary</div>
             <div class="selectable disabled-text">$shortDate</div>
            <a style="margin-top: 7px;" class="toggle primary-color" href="#info" id="info-btn">${S.of(context).btn_show_details}</a>
          </div>
          <div class="flex" style="flex: 0"></div>
        </div>
        </div>
          <div class="toggle-content flex" id="info">
              <div class="row"><a class="details-description">From</a><a class="selectable details-value">$from</a></div>
              <div class="row"><a class="details-description">To</a><a class="selectable details-value">$to</a></div>        
              ${cc.isNotEmpty ? '<div class="row"><a class="details-description">Cc</a><a class="selectable details-value">$cc</a></div>' : ''}
              <div class="row"><a class="details-description">Date</a><a class="selectable details-value">$date</a></div>
          </div>
          ${extendedEvent == null ? "" : """
        <div class="appointment">
          ${_showButtons(extendedEvent["Type"] as String) ? """
           <div class="row">
            <button onclick="acceptEvent()">Accept</button> 
            <button onclick="declineEvent()">Decline</button> 
            <button onclick="tentativeEvent()">Tentative</button> 
          </div>
          <div class="row fluid">
            ${_getCalendarsSelectButton(initCalendar)} 
          </div> 
            """ : ''}
          <div class="row fluid"> 
            <span class="label">When</span><span class="value">${extendedEvent["When"]}</span>  
          </div>
          <div class="row fluid"> 
            <span class="label">Organizer</span><span class="value">${extendedEvent["Organizer"]["Email"]}</span>  
          </div>
          <div class="row fluid"> 
            <span class="label">Attendees</span><span class="value">${_getAttendees(extendedEvent["AttendeeList"] as List)}</span>  
          </div>
          <div class="row fluid"> 
            <span class="label">Title</span><span class="value">${extendedEvent["Summary"]}</span>  
          </div>
          ${extendedEvent["Description"] != null && (extendedEvent["Description"] as String).isNotEmpty ? """ 
          <div class="row fluid"> 
            <span class="label">Description</span><span class="value">${extendedEvent["Description"]}</span>  
          </div>
          """ : ''}
          ${extendedEvent["Location"] != null && (extendedEvent["Location"] as String).isNotEmpty ? """ 
          <div class="row fluid"> 
            <span class="label">Location</span><span class="value">${extendedEvent["Location"]}</span>  
          </div>
          """ : ''}
        </div>
        """}
          
        <div class="email-head" style="padding-top: 0px;">
        <div style="display: flex; flex-direction: row;justify-content: space-between; padding-top: 24px;">
          <h1 style="font-size: 24px; font-weight: 500; margin-top: 0px;">
            <span style="margin-right: 10px;" class="selectable">${subject}</span>
            <span style="display: inline-block; font-size: 14px; background: #B6B5B5; ${theme.brightness == Brightness.dark ? 'color: black;' : 'color: white;'} padding: 3px 8px; border-radius: 10px; margin-top: -2px; vertical-align: middle;">${message.folder}</span>
          </h1>
          <a id="stared-btn" class="stared${isStarred ? " is-starred" : ""}" href='${MessageWebViewActions.ACTION + (isStarred ? MessageWebViewActions.SET_NOT_STARRED : MessageWebViewActions.SET_STARRED)}' style='text-decoration: none; font-size: 24px; line-height: 1.2; color: orange'>${isStarred ? "&#9733;" : "&#9734;"}</a>
        </div>
        <div style="clear: both;height: 1px; background-color: black; opacity: 0.05; margin: 24px 0 0"></div>
      </div>
      <div class="selectable email-content">$body</div>
      ${attachments.isNotEmpty ? '<div style="height: 1px; background-color: black; opacity: 0.05; margin: 24px 0 0"></div>' : ""}
      <div class="attachments">
        ${attachments.where((element) => !element.isInline).map((a) => _getAttachment(context, a)).toList().join()}
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
    final textColor = _getWebColor(theme.textTheme.titleSmall.color);

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
    <div class="attachment">
      $leading
      <div class="flex" style="flex: 1;white-space: nowrap;overflow: hidden;/* text-overflow: ellipsis; */">
        <span style="display: inline-block; max-width: 100%; overflow: hidden; text-overflow: ellipsis;"
          class="selectable">${attachment.fileName}</span>
        <span class="disabled-text">${filesize(attachment.size)}</span>
      </div>
      <a class="icon-btn" onclick="downloadAttachment('${attachment.downloadUrl}')">${_getDownloadIcon(iconColor)}</a>
    </div>
    """;
  }

  static bool _showButtons(String type) {
    final targetString = "REQUEST";
    if (type == null || type.isEmpty) return false;
    if (type == targetString) return true;
    final components = type.split('-');
    if (components.contains(targetString)) return true;
    return false;
  }

  static String _getAttendees(List attendees) {
    if (attendees == null || attendees.isEmpty) return '';
    String result = "";
    for (final e in attendees) {
      result += " ${(e["DisplayName"] as String)}" +
          " &lt;${e["Email"] as String}&gt;" +
          ",";
    }
    result = result.substring(1, result.length - 1);
    return result;
  }

  static String _getCurrentCalendarName(
      {String id, List<ViewCalendar> calendars}) {
    if (id == null || id.isEmpty) return null;
    if (calendars == null || calendars.isEmpty) return null;
    final selectedCalendar =
        calendars.firstWhereOrNull((element) => element.id == id);
    if (selectedCalendar == null) return null;
    return selectedCalendar.name;
  }

  static String _getCalendarsSelectButton(ViewCalendar calendar) {
    if (calendar == null) return "";
    return """ 
      <span class="label">Calendar</span>
      <span class="value">
        <div class="custom-dropdown" onclick="handleDropdownClick()">
          <span class="dropdown-label" id="custom-dropdown-value">${calendar.name}</span>
          <div class="dropdown-arrow"></div>
        </div>
      </span>  
    """;
  }

  static String _getInfoIcon(String color) =>
      """<svg id="information" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">
  <g id="Group_32" data-name="Group">
  <g id="Group_31" data-name="Group">
  <path id="Path_53" data-name="Path 53" d="M10,0A10,10,0,1,0,20,10,9.988,9.988,0,0,0,10,0Zm0,18.34A8.34,8.34,0,1,1,18.34,10,8.354,8.354,0,0,1,10,18.34Z" fill="$color"/>
  </g>
  </g>
  <g id="Group_34" data-name="Group" transform="translate(9.135 7.761)">
  <g id="Group_33" data-name="Group">
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
