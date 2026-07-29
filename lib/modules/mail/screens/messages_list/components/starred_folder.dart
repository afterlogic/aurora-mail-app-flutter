
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/shared_ui/asset_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/app_color.dart';

class StarredFolder extends StatelessWidget {
  final Folder mailFolder;
  final bool isSelected;

  const StarredFolder({
    Key? key,
    required this.mailFolder,
    required this.isSelected,
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
      leading: SizedBox(
        width: 24.0,
        height: 24.0,
        child: AssetSvgIcon(
          showSvg: BuildProperty.useCustomStarIcons,
          svgPath: '${BuildProperty.image_dir}/mail/star.active.svg',
          iconData: Icons.star,
          color: AppColor.starActive,
        ),
      ),
      title: Text(S.of(context).folders_starred),
      onTap: () => _selectFolder(context),
    );
  }
}
