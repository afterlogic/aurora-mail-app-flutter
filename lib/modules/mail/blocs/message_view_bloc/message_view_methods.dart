import 'dart:io';

import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:flutter/widgets.dart';

class MessageViewMethods {
  final _mailApi = new MailApi();

  void downloadAttachment(
    MailAttachment attachment, {
    @required Function(String) onDownloadEnd,
    @required Function() onDownloadStart,
  }) {
    if (Platform.isIOS) {
      _mailApi.shareAttachment(attachment);
    } else {
      _mailApi.downloadAttachment(
        attachment,
        onDownloadEnd: onDownloadEnd,
        onDownloadStart: onDownloadStart,
      );
    }
  }
}
