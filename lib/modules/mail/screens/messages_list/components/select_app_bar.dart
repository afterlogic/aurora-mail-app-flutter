import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_state.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/selection_controller.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/dialog/move_message.dart';
import 'package:aurora_mail/res/icons/app_assets.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/shared_ui/svg_icon.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SelectAppBar extends StatefulWidget {
  final SelectionController<int, Message> controller;
  final bool isAppBar;

  const SelectAppBar(
    this.controller, {
    this.isAppBar = true,
  });

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
        final actions = folderType == null
            ? null
            : <Widget>[
                if (![FolderType.sent, FolderType.drafts, FolderType.spam]
                    .contains(folderType))
                  IconButton(
                    icon: SvgIcon(
                      AppAssets.spam,
                    ),
                    onPressed: () => _spam(true),
                  ),
                if (FolderType.spam == folderType)
                  IconButton(
                    icon: SvgIcon(
                      AppAssets.not_spam,
                    ),
                    onPressed: () => _spam(false),
                  ),
                IconButton(
                  icon: Icon(
                    MdiIcons.fileMove,
                  ),
                  onPressed: _move,
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: _delete,
                ),
              ];
        if (!widget.isAppBar) {
          return ListTile(
            leading: IconButton(
              icon: Icon(
                Icons.close,
              ),
              onPressed: () => widget.controller.enable = false,
            ),
            title: Text(widget.controller.selected.length.toString()),
            trailing: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          );
        }
        return AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.close,
            ),
            onPressed: () => widget.controller.enable = false,
          ),
          title: Text(widget.controller.selected.length.toString()),
          actions: actions,
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
      i18n(context, S.messages_delete_title_with_count),
      i18n(context, S.messages_delete_desc_with_count),
      i18n(context, S.btn_delete),
      destructibleAction: true,
    );
    if (delete == true) {
      BlocProvider.of<MessagesListBloc>(context).add(DeleteMessages(
        messages: messages,
      ));
      widget.controller.enable = false;
    }
  }

  void _move() async {
    final messages = widget.controller.selected.values.toList();
    widget.controller.enable = false;
    AMDialog.show(
      context: context,
      builder: (_) => MoveMessageDialog(
        messages,
        BlocProvider.of<MessagesListBloc>(context),
        BlocProvider.of<MailBloc>(context),
      ),
    );
  }
}
