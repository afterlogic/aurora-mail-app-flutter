import 'dart:convert';
import 'dart:typed_data';

import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/screen/file_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextViewer extends FileViewer {
  @override
  final String url;

  @override
  final Future<Uint8List> future;
  @override
  final MailAttachment attachment;
  TextViewer(this.url, this.future, this.attachment);

  @override
  FileViewerState createState() => _TextViewerState();
}

class _TextViewerState extends FileViewerState {
  @override
  Widget buildContent(BuildContext context) {
    return SingleChildScrollView(child: SelectableText(utf8.decode(content)));
  }
}
