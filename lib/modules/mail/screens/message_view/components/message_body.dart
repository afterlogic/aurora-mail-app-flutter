import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/image_properties.dart';

class MessageBody extends StatelessWidget {
  final Message message;
  final List<MailAttachment> attachments;

  const MessageBody(this.message, this.attachments, {Key key})
      : super(key: key);

  String get data {
    if (message.htmlRaw != null && message.htmlRaw.isNotEmpty) {
      return getHtmlWithImages(message.htmlRaw);
    } else if (message.html != null && message.html.isNotEmpty) {
      return getHtmlWithImages(message.html);
    } else if (message.plainRaw != null && message.plainRaw.isNotEmpty) {
      return message.plainRaw;
    } else if (message.plain != null && message.plain.isNotEmpty) {
      return message.plain;
    } else {
      return "";
    }
  }

  String getHtmlWithImages(String html) {
    String parsedHtml = html;
    attachments.forEach((attachment) {
      parsedHtml = parsedHtml.replaceFirst("cid:${attachment.cid}",
          AppStore.authState.hostName + attachment.viewUrl + "&AuthToken=${AppStore.authState.authToken}");
    });
    return parsedHtml;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Html(
        data: data,
        onImageTap: (String src) {
          print("VO: src: ${src}");
        },
        onImageError: (err, s) {
          print("VO: err: ${err}");
          print("VO: s: ${s}");
        },

      ),
    );
  }
}
