import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbnailWidget extends StatefulWidget {
  final File file;
  final double size;

  const ThumbnailWidget(this.file, this.size);

  @override
  _ThumbnailWidgetState createState() => _ThumbnailWidgetState();
}

class _ThumbnailWidgetState extends State<ThumbnailWidget> {
  ImageProvider provider;

  @override
  void initState() {
    super.initState();
    initImage();
  }

  initImage() async {
    final type = lookupMimeType(widget.file.path).split("/").first;
    if (type == "image") {
      provider = FileImage(widget.file, scale: 5);
    } else if (type == "video") {
      final data = await VideoThumbnail.thumbnailData(
        video: widget.file.path,
      );
      provider = MemoryImage(data, scale: 5);
    } else {
      return;
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (provider == null) {
      return SizedBox.shrink();
    }
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: Center(
        child: Image(
          image: provider,
        ),
      ),
    );
  }
}
