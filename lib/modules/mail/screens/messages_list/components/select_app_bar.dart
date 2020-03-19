import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_state.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/selection_controller.dart';
import 'package:aurora_mail/res/icons/app_assets.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SelectAppBar extends StatefulWidget {
  final SelectionController<int, Message> controller;

  const SelectAppBar(this.controller);

  @override
  _SelectAppBarState createState() => _SelectAppBarState();
}

class _SelectAppBarState extends BState<SelectAppBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(update);
  }

  @override
  void dispose() {
    super.dispose();

    widget.controller.removeListener(update);
  }

  update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(
      condition: (_, state) => state is FoldersLoaded,
      builder: (context, state) {
        final folderType =
            state is FoldersLoaded ? state.selectedFolder.folderType : null;
        return AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => widget.controller.enable = false,
          ),
          title: Text(widget.controller.selected.length.toString()),
          actions: folderType == null
              ? []
              : <Widget>[
                  if ([FolderType.trash, FolderType.spam].contains(folderType))
                    IconButton(
                      icon: Icon(MdiIcons.folderRemoveOutline),
                      onPressed: () => _empty(
                        (state as FoldersLoaded).selectedFolder.fullNameRaw,
                      ),
                    ),
                  if (![FolderType.sent, FolderType.drafts, FolderType.spam]
                      .contains(folderType))
                    IconButton(
                      icon: SvgPicture.asset(
                        AppAssets.spam,
                        color: theme.appBarTheme.iconTheme.color,
                      ),
                      onPressed: () => _spam(true),
                    ),
                  if (FolderType.spam == folderType)
                    IconButton(
                      icon: SvgPicture.asset(
                        AppAssets.not_spam,
                        color: theme.appBarTheme.iconTheme.color,
                      ),
                      onPressed: () => _spam(false),
                    ),
                  IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: _delete,
                  ),
                ],
        );
      },
    );
  }

  void _spam(bool into) {
    final messages = widget.controller.selected.values.toList();
    BlocProvider.of<MessagesListBloc>(context).add(
      MoveMessages(
        messages,
        into ? FolderType.spam : FolderType.inbox,
      ),
    );
    widget.controller.enable = false;
  }

  void _delete() async {
    final messages = widget.controller.selected.values.toList();
    final delete = await ConfirmationDialog.show(
      context,
      i18n(context, "messages_delete_title_with_count"),
      i18n(context, "messages_delete_desc_with_count"),
      i18n(context, "btn_delete"),
      destructibleAction: true,
    );
    if (delete == true) {
      BlocProvider.of<MessagesListBloc>(context).add(DeleteMessages(
        messages: messages,
      ));
      widget.controller.enable = false;
    }
  }

  void _empty(String folder) {
    BlocProvider.of<MessagesListBloc>(context).add(
      EmptyFolder(folder),
    );
    widget.controller.enable = false;
  }
}
