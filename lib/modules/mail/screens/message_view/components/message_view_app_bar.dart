import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum MailViewAppBarAction { reply, replyToAll, forward, toSpam, delete }

class MailViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
  final Function(MailViewAppBarAction) onAppBarActionSelected;

  const MailViewAppBar(this.onAppBarActionSelected, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.reply),
          tooltip: i18n(context, "messages_reply"),
          onPressed: () => onAppBarActionSelected(MailViewAppBarAction.reply),
        ),
        IconButton(
          icon: Icon(Icons.reply_all),
          tooltip: i18n(context, "messages_reply_all"),
          onPressed: () =>
              onAppBarActionSelected(MailViewAppBarAction.replyToAll),
        ),
        IconButton(
          icon: Icon(MdiIcons.share),
          tooltip: i18n(context, "messages_forward"),
          onPressed: () => onAppBarActionSelected(MailViewAppBarAction.forward),
        ),
//        IconButton(
//          icon: Icon(MdiIcons.bugOutline),
//          tooltip: i18n(context, "btn_to_spam"),
//          onPressed: () => onAppBarActionSelected(MailViewAppBarAction.toSpam),
//        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          tooltip: i18n(context, "btn_delete"),
          onPressed: () => onAppBarActionSelected(MailViewAppBarAction.delete),
        ),
      ],
    );
  }
}
