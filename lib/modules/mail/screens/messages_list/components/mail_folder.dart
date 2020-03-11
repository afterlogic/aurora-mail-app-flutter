import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
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
      this.children})
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

  void _selectUnreadOnly(BuildContext context) {
    Navigator.pop(context);
    BlocProvider.of<MailBloc>(context)
        .add(SelectFolder(mailFolder, filter: MessagesFilter.unread));
  }

  Widget _buildMessageCounter(BuildContext context) {
    final theme = Theme.of(context);
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

  @override
  Widget build(BuildContext context) {
    double padding = 40;
    if (mailFolder.nameSpace != null &&
        mailFolder.nameSpace.startsWith(mailFolder.fullName)) {
      padding = 0;
    }
    if (mailFolder.isSubscribed == true) {
      return Column(
        children: <Widget>[
          ListTile(
            selected: isSelected,
            leading: Icon(_folderIcon),
            title: Text(_getTitle(context)),
            trailing: _buildMessageCounter(context),
            onTap: () => _selectFolder(context),
          ),
          Padding(
            padding: EdgeInsets.only(left: padding),
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
