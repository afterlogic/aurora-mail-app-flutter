import 'package:flutter/widgets.dart';

import 'mail_attachment.dart';

class ComposeAttachment {
  final String fileName;
  final String name;
  final String tempName;
  final String mimeType;
  final int size;
  final String hash;
  final String viewUrl;
  final String downloadUrl;
  final String thumbnailUrl;
  String
      guid; // to replace temp attachment with progress with the one from server

  ComposeAttachment({
    @required this.fileName,
    @required this.name,
    @required this.tempName,
    @required this.mimeType,
    @required this.size,
    @required this.hash,
    @required this.viewUrl,
    @required this.downloadUrl,
    @required this.thumbnailUrl,
  });

  static ComposeAttachment fromJsonString(Map item) {
    return new ComposeAttachment(
      fileName: item["FileName"],
      name: item["Name"],
      tempName: item["TempName"],
      mimeType: item["MimeType"],
      size: item["Size"],
      hash: item["Hash"],
      viewUrl: item["Actions"] is Map ? item["Actions"]["view"]["url"] : null,
      downloadUrl:
          item["Actions"] is Map ? item["Actions"]["download"]["url"] : null,
      thumbnailUrl: item["ThumbnailUrl"],
    );
  }

  // used in forward
  // { "temp_name_value": "hash_value" }
  static List<ComposeAttachment> fromMailAttachment(
      List<MailAttachment> mailAttachments, Map tempValues) {
    assert(mailAttachments.length == tempValues.keys.length);

    return mailAttachments.map((a) {
      final i = mailAttachments.indexOf(a);
      return new ComposeAttachment(
        fileName: a.fileName,
        name: a.fileName,
        tempName: tempValues.keys.toList()[i],
        mimeType: a.mimeType,
        size: a.size,
        hash: tempValues.values.toList()[i],
        viewUrl: a.viewUrl,
        downloadUrl: a.downloadUrl,
        thumbnailUrl: a.thumbnailUrl,
      );
    }).toList();
  }
}
