import 'package:flutter/widgets.dart';

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
  String guid; // to replace temp attachment with progress with the one from server

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
}
