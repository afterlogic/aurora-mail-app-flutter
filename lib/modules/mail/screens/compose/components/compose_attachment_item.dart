import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';

class ComposeAttachmentItem extends StatelessWidget {
  final dynamic attachment;
  final Function(dynamic) onCancel;

  const ComposeAttachmentItem(this.attachment, this.onCancel, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    if (attachment is TempAttachmentUpload) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.attach_file),
          ],
        ),
        title: Text(attachment.name as String),
        subtitle: StreamBuilder(
          stream: attachment.uploadProgress as Stream<UploadTaskProgress>,
          builder: (_, AsyncSnapshot<UploadTaskProgress> snapshot) {
            return SizedBox(
              height: 3.0,
              child: LinearProgressIndicator(
                backgroundColor: theme.disabledColor.withOpacity(0.1),
                value: snapshot.connectionState == ConnectionState.active &&
                        snapshot.hasData
                    ? snapshot.data.progress / 100
                    : null,
              ),
            );
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.cancel),
          tooltip: i18n(context, "messages_attachment_upload_cancel"),
          onPressed: () {
            attachment.cancel(taskId: attachment.taskId);
            onCancel(attachment);
          },
        ),
      );
    } else if (attachment is ComposeAttachment) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.attach_file),
          ],
        ),
        title: Text(attachment.fileName as String),
        subtitle: Text(filesize(attachment.size)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.cancel),
              tooltip: i18n(context, "messages_attachment_delete"),
              onPressed: () => onCancel(attachment),
            ),
          ],
        ),
      );
    } else {
      return null;
    }
  }
}
