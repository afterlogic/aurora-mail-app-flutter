//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StarredFolder extends StatelessWidget {
  final Folder mailFolder;
  final bool isSelected;

  const StarredFolder({
    Key key,
    @required this.mailFolder,
    @required this.isSelected,
  }) : super(key: key);

  void _selectFolder(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    BlocProvider.of<MailBloc>(context)
        .add(SelectFolder(mailFolder, filter: MessagesFilter.starred));
  }

  @override
  Widget build(BuildContext context) {
    assert(mailFolder.folderType == FolderType.inbox);

    return ListTile(
      selected: isSelected,
      leading: Icon(Icons.star_border),
      title: Text(S.of(context).folders_starred),
      onTap: () => _selectFolder(context),
    );
  }
}
