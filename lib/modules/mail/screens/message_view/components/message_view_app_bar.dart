import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum MailViewAppBarAction { reply, replyToAll, forward, toSpam, delete }

class MailViewAppBar extends StatelessWidget {
  final Function(MailViewAppBarAction) onAppBarActionSelected;

  const MailViewAppBar(this.onAppBarActionSelected, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.reply),
          tooltip: S.of(context).messages_reply,
          onPressed: () => onAppBarActionSelected(MailViewAppBarAction.reply),
        ),
        IconButton(
          icon: Icon(Icons.reply_all),
          tooltip: S.of(context).messages_reply_all,
          onPressed: () =>
              onAppBarActionSelected(MailViewAppBarAction.replyToAll),
        ),
        IconButton(
          icon: Icon(MdiIcons.share),
          tooltip: S.of(context).messages_forward,
          onPressed: () => onAppBarActionSelected(MailViewAppBarAction.forward),
        ),
//        IconButton(
//          icon: Icon(MdiIcons.bugOutline),
//          tooltip: S.of(context).btn_to_spam,
//          onPressed: () => onAppBarActionSelected(MailViewAppBarAction.toSpam),
//        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          tooltip: S.of(context).btn_delete,
          onPressed: () => onAppBarActionSelected(MailViewAppBarAction.delete),
        ),
      ],
    );
  }
}
