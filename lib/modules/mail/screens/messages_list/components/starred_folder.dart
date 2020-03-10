import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';
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
    Navigator.pop(context);
    BlocProvider.of<MailBloc>(context)
        .add(SelectFolder(mailFolder, isStarredFolder: true));
  }

  @override
  Widget build(BuildContext context) {
    assert(mailFolder.folderType == FolderType.inbox);

    return ListTile(
      selected: isSelected,
      leading: Icon(Icons.star_border),
      title: Text(i18n(context, "folders_starred")),
      onTap: () => _selectFolder(context),
    );
  }
}
