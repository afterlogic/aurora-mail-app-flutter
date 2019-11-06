import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';

class Attachment extends StatelessWidget {
  final MailAttachment attachment;

  const Attachment(this.attachment, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.attach_file),
        ],
      ),
      title: Text(attachment.fileName),
      subtitle: Text(filesize(attachment.size)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (attachment.downloadUrl != null)
            IconButton(
              icon: Icon(Icons.file_download),
              // TODO translate
              tooltip: "Download attachment",
              onPressed: null,
            ),
        ],
      ),
    );
  }
}
