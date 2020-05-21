import 'dart:typed_data';

import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/screen/image_viewer.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/screen/text_viewer.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/screen/video_viewer.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

abstract class FileViewer extends StatefulWidget {
  MailAttachment get attachment;

  String get url;

  Future<Uint8List> get future;

  @override
  FileViewerState createState();

  static Future openFile(
      BuildContext context, MailAttachment attachment) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final url = authBloc.currentUser.hostname + "/" + attachment.downloadUrl;
    final header = {'Authorization': 'Bearer ${authBloc.currentUser.token}'};

    FileViewer viewer;
    final type = attachment.mimeType.split("/").first;
    final format = attachment.mimeType.split("/").last.toLowerCase();
    if (type == "video") {
      viewer = VideoViewer(
        url,
        attachment,
      );
    } else if (type == "image" && _supportedImageFormats.contains(format)) {
      viewer = ImageViewer(
        url,
        get(url, headers: header).then(
          (response) => response.bodyBytes,
        ),
        attachment,
      );
    } else if (type == "text") {
      viewer = TextViewer(
        url,
        get(url, headers: header).then(
          (response) => response.bodyBytes,
        ),
        attachment,
      );
    }
    if (viewer == null) {
      return;
    }
    await AMDialog.show(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(attachment.fileName),
        content: viewer,
        actions: <Widget>[
          FlatButton(
            child: Text(i18n(context, "btn_close")),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  static bool isSupported(MailAttachment attachment) {
    final type = attachment.mimeType.split("/").first;
    final format = attachment.mimeType.split("/").last.toLowerCase();
    if (type == "video") {
      return true;
    } else if (type == "image" && _supportedImageFormats.contains(format)) {
      return true;
    } else if (type == "text") {
      return true;
    }
    return false;
  }

  static const _supportedImageFormats = {
    "jpeg",
    "webp",
    "gif",
    "png",
    "bmp",
    "wbmp"
  };
}

abstract class FileViewerState extends State<FileViewer> {
  Uint8List content;
  dynamic error;

  @override
  void initState() {
    super.initState();
    initContent();
  }

  Future initContent() async {
    widget.future.then((content) {
      this.content = content;
      setState(() {});
    }).catchError((error) {
      this.error = error;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (content != null) {
      return buildContent(context);
    } else if (error != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(i18n(context, "error_connection")),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      );
    }
  }

  Widget buildContent(BuildContext context);
}
