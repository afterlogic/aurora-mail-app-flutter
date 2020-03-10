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

  factory ComposeAttachment.fromNetwork(Map item) {
    return new ComposeAttachment(
      fileName: item["FileName"] as String,
      name: item["Name"] as String,
      tempName: item["TempName"] as String,
      mimeType: item["MimeType"] as String,
      size: item["Size"] as int,
      hash: item["Hash"] as String,
      viewUrl: item["Actions"] is Map
          ? item["Actions"]["view"]["url"] as String
          : null,
      downloadUrl: item["Actions"] is Map
          ? item["Actions"]["download"]["url"] as String
          : null,
      thumbnailUrl: item["ThumbnailUrl"] as String,
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
        tempName: tempValues.keys.toList()[i] as String,
        mimeType: a.mimeType,
        size: a.size,
        hash: tempValues.values.toList()[i] as String,
        viewUrl: a.viewUrl,
        downloadUrl: a.downloadUrl,
        thumbnailUrl: a.thumbnailUrl,
      );
    }).toList();
  }
}
