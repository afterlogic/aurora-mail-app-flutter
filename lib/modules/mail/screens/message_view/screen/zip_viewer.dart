import 'dart:convert';
import 'dart:typed_data';

import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/screen/file_viewer.dart';
import 'package:aurora_mail/shared_ui/sized_dialog_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class ZipViewer extends FileViewer {
  final WebMailApi module;
  final Function(MailAttachment) onOpen;

  @override
  Future<Uint8List> get future => null;

  @override
  final MailAttachment attachment;

  ZipViewer(
    this.module,
    this.attachment,
    this.onOpen,
  );

  @override
  FileViewerState createState() => _TextViewerState();
}

class _TextViewerState extends FileViewerState<ZipViewer> {
  List<MailAttachment> get current => path.isEmpty ? null : path.last;
  List<List<MailAttachment>> path = [];
  bool isProgress = false;

  Future initContent() async {
    await open(widget.attachment.hash);
  }

  open(String hash) async {
    setState(() {});
    isProgress = true;
    try {
      final body = WebMailApiBody(
        method: "ExpandFile",
        parameters: jsonEncode({"Hash": hash}),
      );
      final res = await widget.module.post(body);
      path.add(MailAttachment.fromJson(res["Files"] as List));
    } catch (e) {
      error = e;
    }
    isProgress = false;
    setState(() {});
  }

  @override
  Widget buildContent(BuildContext context) {
    return SizedDialogContent(
      child: ListView(
        children: current.map((item) => attachmentWidget(item)).toList(),
      ),
    );
  }

  Widget attachmentWidget(MailAttachment attachment) {
    return ListTile(
      title: Text(attachment.fileName),
      onTap: () => widget.onOpen(attachment),
    );
  }
}
