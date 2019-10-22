import 'package:aurora_mail/models/folder.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MailFolder extends StatelessWidget {
  final Folder mailFolder;

  const MailFolder({Key key, @required this.mailFolder}) : super(key: key);

  IconData _getFolderIcon(FolderTypes type) {
    switch(type) {
      case FolderTypes.inbox:
        return Icons.inbox;
      case FolderTypes.sent:
        return Icons.send;
      case FolderTypes.drafts:
        return Icons.drafts;
      case FolderTypes.spam:
        return MdiIcons.emailAlert;
      case FolderTypes.trash:
        return MdiIcons.trashCanOutline;
      case FolderTypes.virus:
        return Icons.bug_report;
      case FolderTypes.starred:
        return Icons.star;
      case FolderTypes.template:
        return MdiIcons.fileDocumentEditOutline;
      case FolderTypes.system:
        return Icons.devices;
      case FolderTypes.user:
        return Icons.person;
      case FolderTypes.unknown:
        return Icons.device_unknown;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final level = mailFolder.fullNameRaw.split(mailFolder.delimiter).length;

    if (mailFolder.isSubscribed == true) {
      return Padding(
        padding: EdgeInsets.only(left: (40 * (level - 1)).toDouble()),
        child: ListTile(
          leading: Icon(_getFolderIcon(mailFolder.folderType)),
          title: Text(mailFolder.name),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
