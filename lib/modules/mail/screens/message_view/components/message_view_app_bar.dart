//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/bloc.dart';
import 'package:aurora_mail/res/icons/app_assets.dart';
import 'package:aurora_mail/shared_ui/svg_icon.dart';
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

class MailViewAppBarMock extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const MailViewAppBarMock();

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AMAppBar(),
    );
  }
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
          buildWhen: (_, newS) => newS is FolderTypeState,
          builder: (context, state) {
            final folderType = state is FolderTypeState ? state.type : null;
            final theme = Theme.of(context);
            return AMAppBar(
              actions: folderType == null
                  ? []
                  : [
                      if (![FolderType.sent, FolderType.drafts]
                          .contains(folderType))
                        IconButton(
                          icon: Icon(Icons.reply),
                          tooltip: S.of(context).messages_reply,
                          onPressed: () => onAppBarActionSelected(
                              MailViewAppBarAction.reply),
                        ),
                      IconButton(
                        icon: Icon(Icons.delete_outline),
                        tooltip: S.of(context).btn_delete,
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
                                leading: Icon(Icons.reply_all, color: theme.brightness == Brightness.light ? Colors.black : null,),
                                title: Text(S.of(context).messages_reply_all),
                              ),
                            ),
                          if (folderType != FolderType.drafts)
                            PopupMenuItem(
                              value: MailViewAppBarAction.forward,
                              child: ListTile(
                                leading: Icon(MdiIcons.share, color: theme.brightness == Brightness.light ? Colors.black : null,),
                                title: Text(S.of(context).messages_forward),
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
                                   color: theme.brightness == Brightness.light ? Colors.black : null,
                                ),
                                title: Text(S.of(context).btn_to_spam),
                              ),
                            ),
                          if (folderType == FolderType.spam)
                            PopupMenuItem(
                              value: MailViewAppBarAction.notSpam,
                              child: ListTile(
                                leading: SvgIcon(
                                  AppAssets.not_spam,
                                   color: theme.brightness == Brightness.light ? Colors.black : null,
                                ),
                                title: Text(S.of(context).btn_not_spam),
                              ),
                            ),
                          if (folderType == FolderType.sent)
                            PopupMenuItem(
                              value: MailViewAppBarAction.resend,
                              child: ListTile(
                                leading: SvgIcon(
                                  AppAssets.resend,
                                   color: theme.brightness == Brightness.light ? Colors.black : null,
                                ),
                                title: Text(S.of(context).btn_message_resend),
                              ),
                            ),
                          PopupMenuItem(
                            value: MailViewAppBarAction.move,
                            child: ListTile(
                              leading: Icon(MdiIcons.fileMove, color: theme.brightness == Brightness.light ? Colors.black : null,),
                              title: Text(
                                  S.of(context).label_message_move_to_folder),
                            ),
                          ),
                          PopupMenuItem(
                            value: MailViewAppBarAction.showHeaders,
                            child: ListTile(
                              leading: Icon(Icons.code, color: theme.brightness == Brightness.light ? Colors.black : null,),
                              title: Text(S.of(context).label_message_headers),
                            ),
                          ),
                          PopupMenuItem(
                            value: MailViewAppBarAction.forwardAsAttachment,
                            child: ListTile(
                              leading: Icon(Icons.forward, color: theme.brightness == Brightness.light ? Colors.black : null,),
                              title: Text(
                                  S.of(context).label_forward_as_attachment),
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
