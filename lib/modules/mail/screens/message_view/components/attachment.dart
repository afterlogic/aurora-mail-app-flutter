import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Attachment extends StatefulWidget {
  final MailAttachment attachment;

  const Attachment(this.attachment, {Key key}) : super(key: key);

  @override
  _AttachmentState createState() => _AttachmentState();
}

class _AttachmentState extends State<Attachment> {
  DownloadTaskProgress _taskProgress;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageViewBloc, MessageViewState>(
      listener: (context, state) {
        // TODO repair progress updating
//        if (state is DownloadStarted) {
//          setState(() {
//            _taskProgress = widget.attachment.getDownloadTask();
//          });
//        }
//        if (state is DownloadFinished) {
//          setState(() {
//            _taskProgress = null;
//          });
//        }
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.attach_file),
          ],
        ),
        title: Text(widget.attachment.fileName),
        subtitle: _taskProgress == null
            ? Text(filesize(widget.attachment.size))
            : StreamBuilder(
                stream: _taskProgress.progressStream,
                builder: (_, AsyncSnapshot<int> snapshot) {
                  return SizedBox(
                    height: 3.0,
                    child: LinearProgressIndicator(
                      backgroundColor:
                          Theme.of(context).disabledColor.withOpacity(0.1),
                      value:
                          snapshot.connectionState == ConnectionState.active &&
                                  snapshot.hasData
                              ? snapshot.data / 100
                              : null,
                    ),
                  );
                },
              ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (widget.attachment.downloadUrl != null && _taskProgress == null)
              IconButton(
                icon: Icon(Icons.file_download),
                tooltip: S.of(context).messages_attachment_download,
                onPressed: () {
                  showSnack(
                      context: context,
                      scaffoldState: Scaffold.of(context),
                      msg: S.of(context).messages_attachment_downloading(widget.attachment.fileName),
                      isError: false);
                  BlocProvider.of<MessageViewBloc>(context)
                      .add(DownloadAttachment(widget.attachment));
                },
              ),
            if (_taskProgress != null)
              IconButton(
                icon: Icon(Icons.cancel),
                tooltip: S.of(context).messages_attachment_download_cancel,
                onPressed: () => setState(() {
                  widget.attachment.endDownloading(_taskProgress.taskId);
                  _taskProgress = null;
                }),
              ),
          ],
        ),
      ),
    );
  }
}
