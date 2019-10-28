import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MessageItem extends StatefulWidget {
  final Message message;

  MessageItem(this.message);

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    final message = widget.message;

    final flags = Mail.getFlags(message.flagsInJson);

    final textStyle = TextStyle(
        fontWeight: flags.contains(MessageFlags.seen)
            ? FontWeight.w400
            : FontWeight.w700);

    return ListTile(
      key: Key(message.uid.toString()),
      contentPadding: EdgeInsets.zero,
      title: Text(message.fromToDisplay, style: textStyle),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (message.hasThread == true)
              Icon(MdiIcons.forumOutline,
                  color: Theme.of(context).disabledColor, size: 16.0),
            if (message.hasThread == true) SizedBox(width: 6.0),
            Flexible(
              child: Text(
                message.subject,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (message.hasAttachments) Icon(Icons.attachment),
              SizedBox(width: 6.0),
              Text(
//                DateFormatting.formatDateFromSeconds(
//                    timestamp: message.timeStampInUTC),
              message.uid.toString(),
                style: textStyle,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (flags.contains(MessageFlags.answered))
                Padding(
                  padding: const EdgeInsets.only(left: .0),
                  child: Icon(Icons.reply),
                ),
              if (flags.contains(MessageFlags.forwarded))
                Padding(
                  padding: const EdgeInsets.only(left: .0),
                  child: Icon(MdiIcons.share),
                ),
              if (flags.contains(MessageFlags.starred))
                Padding(
                  padding: const EdgeInsets.only(left: .0),
                  child: Icon(Icons.star, color: Colors.amber),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
