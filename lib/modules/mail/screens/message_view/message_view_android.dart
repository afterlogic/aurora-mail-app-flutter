import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/components/message_view_app_bar.dart';
import 'package:flutter/material.dart';

import 'components/attachment.dart';
import 'components/message_body.dart';

class MessageViewAndroid extends StatefulWidget {
  final List<Message> messages;
  final int initialPage;

  const MessageViewAndroid(this.messages, this.initialPage);

  @override
  _MessageViewAndroidState createState() => _MessageViewAndroidState();
}

class _MessageViewAndroidState extends State<MessageViewAndroid> {
  PageController _pageCtrl;
  int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageCtrl = new PageController(initialPage: _currentPage, keepPage: false);
  }

  void _onAppBarActionSelected(MailViewAppBarAction action) {
    print("VO: _onAppBarActionSelected: $action");
  }

  String _formatTo(Message message) {
    final items =
        Mail.getToForDisplay(message.toInJson, AppStore.authState.userEmail);

    // TODO translate
    if (items.isEmpty) {
      return "No receivers";
    } else {
      return items.join(" | ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(APP_BAR_HEIGHT_ANDROID),
          child: MailViewAppBar(_onAppBarActionSelected),
        ),
        body: PageView.builder(
          onPageChanged: (int i) => _currentPage = i,
          controller: _pageCtrl,
          itemCount: widget.messages.length,
          itemBuilder: (_, int i) {
            final message = widget.messages[i];
            final attachments = MailAttachment.fromJsonString(
              message.attachmentsInJson,
            );

            return ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                Text(
                  // TODO translate
                  message.subject.isNotEmpty ? message.subject : "No subject",
                  style: Theme.of(context).textTheme.display1.copyWith(
                        fontSize: 26.0,
                      ),
                ),
                SizedBox(height: 12.0),
                Divider(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      message.fromToDisplay,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    Text(message.uid.toString()),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    // TODO translate
                    Text(
                      _formatTo(message),
                      style: Theme.of(context).textTheme.caption,
                    ),
                    // TODO translate
                    Text(
                      "Show details",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                if (attachments.isNotEmpty) Divider(),
                ...attachments.map((attachment) {
                  if (attachment.isInline) {
                    return SizedBox();
                  } else {
                    return Attachment(attachment);
                  }
                }).toList(),
                Divider(height: 24.0),
                MessageBody(message, attachments),
              ],
            );
          },
        ));
  }
}
