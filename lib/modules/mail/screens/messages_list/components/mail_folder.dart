import 'dart:math';

import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MailFolder extends StatelessWidget {
  final Folder mailFolder;
  final bool isSelected;

  const MailFolder(
      {Key key,
      @required this.mailFolder,
      @required this.isSelected,
      int paddingCount})
      : super(key: key);

  IconData get _folderIcon {
    switch (mailFolder.folderType) {
      case FolderType.inbox:
        return Icons.inbox;
      case FolderType.sent:
        return Icons.send;
      case FolderType.drafts:
        return Icons.drafts;
      case FolderType.spam:
        return MdiIcons.emailAlert;
      case FolderType.trash:
        return MdiIcons.trashCanOutline;
      case FolderType.virus:
        return Icons.bug_report;
      case FolderType.starred:
        return Icons.star;
      case FolderType.template:
        return MdiIcons.fileDocumentEditOutline;
      case FolderType.system:
        return Icons.devices;
      case FolderType.user:
        return Icons.folder;
      case FolderType.unknown:
        return Icons.device_unknown;
      default:
        return null;
    }
  }

  String _getTitle(BuildContext context) {
    switch (mailFolder.folderType) {
      case FolderType.inbox:
        return i18n(context, "folders_inbox");
      case FolderType.sent:
        return i18n(context, "folders_sent");
      case FolderType.drafts:
        return i18n(context, "folders_drafts");
      case FolderType.spam:
        return i18n(context, "folders_spam");
      case FolderType.trash:
        return i18n(context, "folders_trash");
      default:
        return mailFolder.name;
    }
  }


  void _selectFolder(BuildContext context) {
    Navigator.pop(context);
    BlocProvider.of<MailBloc>(context).add(SelectFolder(mailFolder));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    Widget _buildMessageCounter(BuildContext context) {

      if (mailFolder.unread != null && mailFolder.unread > 0 ||
          mailFolder.folderType == FolderType.drafts &&
              mailFolder.count != null &&
              mailFolder.count > 0) {
        return Container(
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
      return Padding(
        padding: EdgeInsets.only(left: paddingCount * paddingStep),
        child: ListTile(
          selected: isSelected,
          leading: Icon(_folderIcon),
          title: Text(_getTitle(context)),
          trailing: _buildMessageCounter(context),
          onTap: () => _selectFolder(context),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
