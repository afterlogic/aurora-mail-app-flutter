import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/message_view_bloc.dart';
import 'package:aurora_mail/res/icons/app_assets.dart';
import 'package:aurora_mail/shared_ui/svg_icon.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum MailViewAppBarAction {
  move,
  reply,
  replyToAll,
  showHeaders,
  forward,
  toSpam,
  notSpam,
  resend,
  showLightEmail,
  delete,
  forwardAsAttachment,
}

class MailViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
  final Function(MailViewAppBarAction) onAppBarActionSelected;
  final MessageViewBloc bloc;

  const MailViewAppBar(this.onAppBarActionSelected, this.bloc, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: BlocBuilder<MessageViewBloc, MessageViewState>(
          bloc: bloc,
          condition: (_, newS) => newS is FolderTypeState,
          builder: (context, state) {
            final folderType = state is FolderTypeState ? state.type : null;
            return AMAppBar(
              actions: folderType == null
                  ? []
                  : [
                      if (![FolderType.sent, FolderType.drafts]
                          .contains(folderType))
                        IconButton(
                          icon: Icon(Icons.reply),
                          tooltip: i18n(context, "messages_reply"),
                          onPressed: () => onAppBarActionSelected(
                              MailViewAppBarAction.reply),
                        ),
                      IconButton(
                        icon: Icon(Icons.delete_outline),
                        tooltip: i18n(context, "btn_delete"),
                        onPressed: () =>
                            onAppBarActionSelected(MailViewAppBarAction.delete),
                      ),
                      PopupMenuButton<MailViewAppBarAction>(
                        onSelected: onAppBarActionSelected,
                        itemBuilder: (BuildContext context) => [
                          if (![FolderType.sent, FolderType.drafts]
                              .contains(folderType))
                            PopupMenuItem(
                              value: MailViewAppBarAction.replyToAll,
                              child: ListTile(
                                leading: Icon(Icons.reply_all),
                                title:
                                    Text(i18n(context, "messages_reply_all")),
                              ),
                            ),
                          if (folderType != FolderType.drafts)
                            PopupMenuItem(
                              value: MailViewAppBarAction.forward,
                              child: ListTile(
                                leading: Icon(MdiIcons.share),
                                title: Text(i18n(context, "messages_forward")),
                              ),
                            ),
                          if (![
                            FolderType.sent,
                            FolderType.drafts,
                            FolderType.spam
                          ].contains(folderType))
                            PopupMenuItem(
                              value: MailViewAppBarAction.toSpam,
                              child: ListTile(
                                leading: SvgIcon(
                                  AppAssets.spam,
                                ),
                                title: Text(i18n(context, "btn_to_spam")),
                              ),
                            ),
                          if (folderType == FolderType.spam)
                            PopupMenuItem(
                              value: MailViewAppBarAction.notSpam,
                              child: ListTile(
                                leading: SvgIcon(
                                  AppAssets.not_spam,
                                ),
                                title: Text(i18n(context, "btn_not_spam")),
                              ),
                            ),
                          if (folderType == FolderType.sent)
                            PopupMenuItem(
                              value: MailViewAppBarAction.resend,
                              child: ListTile(
                                leading: SvgIcon(
                                  AppAssets.resend,
                                ),
                                title:
                                    Text(i18n(context, "btn_message_resend")),
                              ),
                            ),
                          PopupMenuItem(
                            value: MailViewAppBarAction.move,
                            child: ListTile(
                              leading: Icon(MdiIcons.fileMove),
                              title: Text(i18n(
                                  context, "label_message_move_to_folder")),
                            ),
                          ),
                          PopupMenuItem(
                            value: MailViewAppBarAction.showHeaders,
                            child: ListTile(
                              leading: Icon(Icons.code),
                              title:
                                  Text(i18n(context, "label_message_headers")),
                            ),
                          ),
                          PopupMenuItem(
                            value: MailViewAppBarAction.forwardAsAttachment,
                            child: ListTile(
                              leading: Icon(Icons.forward),
                              title: Text(
                                  i18n(context, "label_forward_as_attachment")),
                            ),
                          ),
                        ],
                      ),
                    ],
            );
          }),
    );
  }
}
