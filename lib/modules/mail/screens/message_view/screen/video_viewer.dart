import 'dart:convert';
import 'dart:typed_data';

import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/screen/file_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';

class VideoViewer extends FileViewer {
  @override
  final String url;

  @override
  Future<Uint8List> get future => null;
  @override
  final MailAttachment attachment;

  VideoViewer(this.url, this.attachment);

  @override
  FileViewerState createState() => _VideoViewerState();
}

class _VideoViewerState extends FileViewerState {
  VideoPlayerController _controller;

  @override
  Future initContent() async {
    _controller = VideoPlayerController.network(widget.url);
    await _controller.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return buildContent(context);
  }

  @override
  Widget buildContent(BuildContext context) {
    return _controller.value.initialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Container();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
