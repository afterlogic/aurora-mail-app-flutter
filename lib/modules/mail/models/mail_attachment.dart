import 'dart:convert';

import 'package:flutter/widgets.dart';

class MailAttachment {
  final String fileName;
  final String mimeType;
  final String mimePartIndex;
  final int size;
  final String contentLocation;
  final String location;
  final String cid;
  final bool isInline;
  final bool isLinked;
  final String hash;
  final String viewUrl;
  final String downloadUrl;

  MailAttachment({
    @required this.fileName,
    @required this.mimeType,
    @required this.mimePartIndex,
    @required this.size,
    @required this.contentLocation,
    @required this.location,
    @required this.cid,
    @required this.isInline,
    @required this.isLinked,
    @required this.hash,
    @required this.viewUrl,
    @required this.downloadUrl,
  });

  static List<MailAttachment> fromJsonString(String jsonString) {
    if (jsonString == null) return [];
    final Map attachments = json.decode(jsonString);

    final List collection = attachments["@Collection"];

    if (collection == null || collection.isEmpty) return [];

    return collection.map((item) {
      return new MailAttachment(
        fileName: item["FileName"],
        mimeType: item["MimeType"],
        mimePartIndex: item["MimePartIndex"],
        size: item["EstimatedSize"],
        cid: item["CID"],
        contentLocation: item["ContentLocation"],
        location: item["Content"],
        isInline: item["IsInline"],
        isLinked: item["IsLinked"],
        hash: item["Hash"],
        viewUrl: item["Actions"] is Map ? item["Actions"]["view"]["url"] : null,
        downloadUrl:
            item["Actions"] is Map ? item["Actions"]["download"]["url"] : null,
      );
    }).toList();
  }
}
