import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'attachment.dart';

class AttachmentsDialog extends StatefulWidget {
  final List<MailAttachment> attachments;

  AttachmentsDialog(this.attachments);

  static Future<void> show(BuildContext context,
      List<MailAttachment> attachments, MessageViewBloc bloc) {
    return dialog(
        context: context,
        builder: (_) {
          return BlocProvider.value(
              value: bloc, child: AttachmentsDialog(attachments));
        });
  }

  @override
  _AttachmentsDialogState createState() => _AttachmentsDialogState();
}

class _AttachmentsDialogState extends BState<AttachmentsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).messages_view_tab_attachments),
      content: AMDialogList(
        children: widget.attachments.map((attachment) {
          if (attachment.isInline) {
            return SizedBox();
          } else {
            return Attachment(attachment);
          }
        }).toList(),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            S.of(context).btn_close,
            style: TextStyle(
                color: theme.brightness == Brightness.light
                    ? theme.accentColor
                    : null),
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}
