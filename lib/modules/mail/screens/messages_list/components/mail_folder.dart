import 'dart:math';

import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_state.dart';
import 'package:aurora_mail/res/icons/app_assets.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/shared_ui/svg_icon.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MailFolder extends StatelessWidget {
  final Folder mailFolder;
  final bool isSelected;
  final List<Widget> children;

  const MailFolder(
      {Key key,
      @required this.mailFolder,
      @required this.isSelected,
      int paddingCount,
      @required this.children})
      : super(key: key);

  void _selectFolder(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    BlocProvider.of<MailBloc>(context).add(SelectFolder(mailFolder));
  }

  void _selectUnreadOnly(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    BlocProvider.of<MailBloc>(context)
        .add(SelectFolder(mailFolder, filter: MessagesFilter.unread));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget _buildMessageCounter(BuildContext context) {
      if (mailFolder.unread != null && mailFolder.unread > 0 ||
          mailFolder.folderType == FolderType.drafts &&
              mailFolder.count != null &&
              mailFolder.count > 0) {
        return InkWell(
          onTap: mailFolder.folderType != FolderType.drafts
              ? () => _selectUnreadOnly(context)
              : null,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              color: isSelected ? theme.accentColor : theme.disabledColor,
            ),
            child: Text(
              mailFolder.folderType == FolderType.drafts
                  ? mailFolder.count.toString()
                  : mailFolder.unread.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      } else {
        return null;
      }
    }

    final paddingStep = 40.0;
    var paddingCount =
        mailFolder.delimiter.allMatches(mailFolder.fullName).length;
    if (mailFolder.nameSpace?.isNotEmpty == true &&
        mailFolder.fullName.startsWith(mailFolder.nameSpace)) {
      paddingCount -= 1;
    }
    paddingCount = max(paddingCount, 0);
    if (mailFolder.isSubscribed == true) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: paddingCount * paddingStep),
            child: ListTile(
              selected: isSelected,
              leading: FolderHelper.getIcon(mailFolder),
              title: Text(FolderHelper.getTitle(context, mailFolder)),
              trailing: _buildMessageCounter(context),
              onTap: () => _selectFolder(context),
            ),
          ),
          Column(
            children: children,
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }
}

class FolderHelper {
  static String getTitle(BuildContext context, Folder folder) {
    return folder.displayName(context);
  }

  static Widget getIcon(Folder folder) {
    switch (folder.folderType) {
      case FolderType.inbox:
        return Icon(Icons.inbox);
      case FolderType.sent:
        return Icon(Icons.send);
      case FolderType.drafts:
        return Icon(Icons.drafts);
      case FolderType.spam:
        return SvgIcon(AppAssets.spam);
      case FolderType.trash:
        return Icon(MdiIcons.trashCanOutline);
      case FolderType.virus:
        return Icon(Icons.bug_report);
      case FolderType.starred:
        return Icon(Icons.star);
      case FolderType.template:
        return Icon(MdiIcons.fileDocumentEditOutline);
      case FolderType.system:
        return Icon(Icons.devices);
      case FolderType.user:
        return Icon(Icons.folder);
      case FolderType.unknown:
        return Icon(Icons.device_unknown);
      default:
        return null;
    }
  }
}
