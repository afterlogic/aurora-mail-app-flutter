import 'dart:io';

import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mime/mime.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class ThumbnailWidget extends StatefulWidget {
  final File file;
  final double size;
  final ComposeAttachment attachment;

  const ThumbnailWidget(this.attachment, this.file, this.size);

  @override
  _ThumbnailWidgetState createState() => _ThumbnailWidgetState();
}

class _ThumbnailWidgetState extends State<ThumbnailWidget> {
  ImageProvider provider;
  String extension;

  @override
  void initState() {
    super.initState();
    initImage();
  }

  initImage() async {
    if (widget.file != null) {
      final name = widget.file.path.split("/").last;
      final extension = name.split(".").last;
      if (name != extension) {
        this.extension = ".$extension";
      }
      try {
        final type = lookupMimeType(widget.file.path).split("/").first;
        if (this.extension == null) {
          this.extension = type;
        }
        if (type == "image") {
          provider = FileImage(widget.file, scale: 5);
        } else if (type == "video") {
          final data = await VideoThumbnail.thumbnailData(
            video: widget.file.path,
          );
          provider = MemoryImage(data, scale: 5);
        } else {}
      } catch (e) {}
    }
    if (provider == null && widget.attachment.thumbnailUrl != null) {
      final user = BlocProvider.of<AuthBloc>(context).currentUser;
      provider = NetworkImage(
        user.hostname + widget.attachment.thumbnailUrl,
        headers: WebMailApi.getHeaderWithToken(user.token),
      );
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (provider == null) {
      if (widget.size > 100) {
        return SizedBox(
          height: widget.size,
          width: widget.size,
          child: Center(
            child: Text(
              extension,
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 30),
            ),
          ),
        );
      } else {
        return SizedBox.shrink();
      }
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
