import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
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
      this.children})
      : super(key: key);

  IconData _getFolderIcon(FolderType type) {
    switch (type) {
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
        return Icons.person;
      case FolderType.unknown:
        return Icons.device_unknown;
      default:
        return null;
    }
  }

  Widget _buildMessageCounter(BuildContext context) {
    if (mailFolder.unread != null && mailFolder.unread > 0 ||
        mailFolder.folderType == FolderType.drafts &&
            mailFolder.count != null &&
            mailFolder.count > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          color: Theme.of(context).accentColor,
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

  void _selectFolder(BuildContext context) {
    Navigator.pop(context);
    BlocProvider.of<MailBloc>(context).add(SelectFolder(mailFolder));
  }

  @override
  Widget build(BuildContext context) {
    if (mailFolder.isSubscribed == true) {
      return Column(
        children: <Widget>[
          ListTile(
            selected: isSelected,
            leading: Icon(_getFolderIcon(mailFolder.folderType)),
            title: Text(mailFolder.name),
            trailing: _buildMessageCounter(context),
            onTap: () => _selectFolder(context),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Column(
              children: children,
            ),
          )
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
