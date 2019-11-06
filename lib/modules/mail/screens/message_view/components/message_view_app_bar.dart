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
        // TODO translate tooltips
        IconButton(
          icon: Icon(Icons.reply),
          tooltip: "Reply",
          onPressed: () => onAppBarActionSelected(MailViewAppBarAction.reply),
        ),
        IconButton(
          icon: Icon(Icons.reply_all),
          tooltip: "Reply to all",
          onPressed: () =>
              onAppBarActionSelected(MailViewAppBarAction.replyToAll),
        ),
        IconButton(
          icon: Icon(MdiIcons.share),
          tooltip: "Forward",
          onPressed: () => onAppBarActionSelected(MailViewAppBarAction.forward),
        ),
//        IconButton(
//          icon: Icon(MdiIcons.bugOutline),
//          tooltip: "To spam",
//          onPressed: () => onAppBarActionSelected(MailViewAppBarAction.toSpam),
//        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          tooltip: "Delete",
          onPressed: () => onAppBarActionSelected(MailViewAppBarAction.delete),
        ),
      ],
    );
  }
}
