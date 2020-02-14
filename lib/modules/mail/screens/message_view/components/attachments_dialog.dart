import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'attachment.dart';

class AttachmentsDialog extends StatefulWidget {
  final List<MailAttachment> attachments;
  AttachmentsDialog(this.attachments);

  static Future<void> show(BuildContext context, List<MailAttachment> attachments, MessageViewBloc bloc) {
    return dialog(context: context, builder: (_) {
      return BlocProvider.value(value: bloc, child: AttachmentsDialog(attachments));
    });
  }

  @override
  _AttachmentsDialogState createState() => _AttachmentsDialogState();
}

class _AttachmentsDialogState extends State<AttachmentsDialog> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text(i18n(context, "messages_view_tab_attachments")),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: screenHeight / 2),
        child: SingleChildScrollView(
          child: Column(
            children: widget.attachments.map((attachment) {
              if (attachment.isInline) {
                return SizedBox();
              } else {
                return Attachment(attachment);
              }
            }).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, "btn_close")),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}
