import 'dart:convert';
import 'dart:io';
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
import 'package:webmail_api_client/webmail_api_client.dart';
import 'zip_viewer.dart';

abstract class FileViewer extends StatefulWidget {
  MailAttachment get attachment;

  Future<Uint8List> get future;

  @override
  FileViewerState createState();

  static Future openFile(
    BuildContext context,
    MailAttachment attachment,
    String path,
    Function(MailAttachment) onOpen,
  ) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final url = authBloc.currentUser.hostname + "/" + attachment.downloadUrl;
    final header = {'Authorization': 'Bearer ${authBloc.currentUser.token}'};

    FileViewer viewer;
    final type = attachment.mimeType.split("/").first;
    final format = attachment.mimeType.split("/").last.toLowerCase();
    if (type == "video") {
      viewer = path != null
          ? VideoViewer.local(
              path,
              attachment,
            )
          : VideoViewer.network(
              url + "/view/get-expired-link" /*url*/,
              format,
              header,
              attachment,
            );
    } else if (type == "image" && _supportedImageFormats.contains(format)) {
      viewer = ImageViewer(
        url,
        path != null
            ? _getFileContent(path)
            : get(url, headers: header).then(
                (response) => response.bodyBytes,
              ),
        attachment,
      );
    } else if (type == "text") {
      viewer = TextViewer(
        url,
        path != null
            ? _getFileContent(path)
            : get(url, headers: header).then(
                (response) => response.bodyBytes,
              ),
        attachment,
      );
    } else if (type == "application" && format == "zip") {
      final module = WebMailApi(
        moduleName: "MailZipWebclientPlugin",
        hostname: authBloc.currentUser.hostname,
        token: authBloc.currentUser.token,
      );

      viewer = ZipViewer(
        module,
        attachment,
        onOpen,
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

  static Future<Uint8List> _getFileContent(String path) {
    return File(path).readAsBytes();
  }

  static bool isSupported(
      MailAttachment attachment, bool allowVideo, bool exist) {
    final type = attachment.mimeType.split("/").first;
    final format = attachment.mimeType.split("/").last.toLowerCase();
    if (type == "video" && (allowVideo || exist)) {
      return true;
    } else if (type == "image" && _supportedImageFormats.contains(format)) {
      return true;
    } else if (type == "text") {
      return true;
    } else if (type == "application" && format == "zip") {
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

abstract class FileViewerState<T extends FileViewer> extends State<T> {
  Uint8List content;
  dynamic error;

  bool get isProgress => content == null;

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
    if (isProgress) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      );
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
      return buildContent(context);
    }
  }

  Widget buildContent(BuildContext context);
}
