import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/screen/file_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';
import 'package:video_player/video_player.dart';

class VideoViewer extends FileViewer {
  @override
  final String url;
  final bool isLocal;
  final Map<String, String> header;
  final String format;

  @override
  Future<Uint8List> get future => null;
  @override
  final MailAttachment attachment;

  VideoViewer.network(this.url, this.format, this.header, this.attachment)
      : isLocal = false;

  VideoViewer.local(this.url, this.attachment)
      : isLocal = true,
        header = null,
        format = null;

  @override
  FileViewerState createState() => _VideoViewerState();
}

class _VideoViewerState extends FileViewerState<VideoViewer> {
  VideoPlayerController _controller;

  @override
  bool get isProgress => _controller?.value?.initialized != true;

  @override
  Future initContent() async {
    _controller = widget.isLocal
        ? VideoPlayerController.file(File(widget.url))
        : VideoPlayerController.network(await initLink(),
            formatHint: VideoFormat.other);
    await _controller.initialize();
    _controller.addListener(listener);
    setState(() {});
  }

  Future<String> initLink() async {
    final client = HttpClient();

    final request = await client.getUrl(Uri.parse(widget.url));
    request.followRedirects = false;
    widget.header.entries.forEach((item) =>
        request.headers.set(item.key, item.value)); // or headers.add()
    final response = await request.close();
    return response.headers["location"].first + ".${widget.format}";
  }

  listener() {
    setState(() {});
  }

  String formatDuration(Duration duration) {
    return "${duration.inHours}:${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        Text(
            "${formatDuration(_controller.value.position)}/${formatDuration(_controller.value.duration)}"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.fast_rewind),
              onPressed: () async {
                final position =
                    max(0, _controller.value.position.inSeconds - 10);
                await _controller.seekTo(Duration(seconds: position));
              },
            ),
            IconButton(
              icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () async {
                if (_controller.value.duration == _controller.value.position) {
                  await _controller.seekTo(Duration(seconds: 0));
                } else if (_controller.value.isPlaying) {
                  await _controller.pause();
                } else {
                  await _controller.play();
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.fast_forward),
              onPressed: () async {
                final position = min(_controller.value.duration.inSeconds,
                    _controller.value.position.inSeconds + 10);
                await _controller.seekTo(Duration(seconds: position));
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
