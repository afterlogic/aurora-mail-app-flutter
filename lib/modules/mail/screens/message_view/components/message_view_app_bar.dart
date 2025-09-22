//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/bloc.dart';
import 'package:aurora_mail/shared_ui/app_bar_icons.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            return AMAppBar(
              shadow: BoxShadow(color: Colors.transparent),
              leading: IconButton(
                icon: AppBarIcons.back(context: context),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: folderType == null
                  ? []
                  : [
                      if (![FolderType.sent, FolderType.drafts]
                          .contains(folderType))
                        IconButton(
                          icon: AppBarIcons.reply(context: context),
                          tooltip: S.of(context).messages_reply,
                          onPressed: () => onAppBarActionSelected(
                              MailViewAppBarAction.reply),
                        ),
                      IconButton(
                        icon: AppBarIcons.delete(context: context),
                        tooltip: S.of(context).btn_delete,
                        onPressed: () =>
                            onAppBarActionSelected(MailViewAppBarAction.delete),
                      ),
                      PopupMenuButton<MailViewAppBarAction>(
                        icon: AppBarIcons.menu(context: context),
                        onSelected: onAppBarActionSelected,
                        itemBuilder: (BuildContext context) => [
                          if (![FolderType.sent, FolderType.drafts]
                              .contains(folderType))
                            PopupMenuItem(
                              value: MailViewAppBarAction.replyToAll,
                              child: ListTile(
                                leading: AppBarIcons.replyAll(context: context),
                                title: Text(S.of(context).messages_reply_all),
                              ),
                            ),
                          if (folderType != FolderType.drafts)
                            PopupMenuItem(
                              value: MailViewAppBarAction.forward,
                              child: ListTile(
                                leading: AppBarIcons.forward(context: context),
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
                                leading: AppBarIcons.spam(context: context),
                                title: Text(S.of(context).btn_to_spam),
                              ),
                            ),
                          if (folderType == FolderType.spam)
                            PopupMenuItem(
                              value: MailViewAppBarAction.notSpam,
                              child: ListTile(
                                leading: AppBarIcons.not_spam(context: context),
                                title: Text(S.of(context).btn_not_spam),
                              ),
                            ),
                          if (folderType == FolderType.sent)
                            PopupMenuItem(
                              value: MailViewAppBarAction.resend,
                              child: ListTile(
                                leading: AppBarIcons.resend(context: context),
                                title: Text(S.of(context).btn_message_resend),
                              ),
                            ),
                          PopupMenuItem(
                            value: MailViewAppBarAction.move,
                            child: ListTile(
                              leading: AppBarIcons.move(context: context),
                              title: Text(
                                  S.of(context).label_message_move_to_folder),
                            ),
                          ),
                          PopupMenuItem(
                            value: MailViewAppBarAction.showHeaders,
                            child: ListTile(
                              leading: AppBarIcons.headers(context: context),
                              title: Text(S.of(context).label_message_headers),
                            ),
                          ),
                          PopupMenuItem(
                            value: MailViewAppBarAction.forwardAsAttachment,
                            child: ListTile(
                              leading: AppBarIcons.forwardAsAttachment(
                                  context: context),
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
