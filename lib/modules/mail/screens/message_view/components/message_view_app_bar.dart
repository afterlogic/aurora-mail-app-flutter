import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/message_view_bloc.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum MailViewAppBarAction {
  reply,
  replyToAll,
  forward,
  toSpam,
  notSpam,
  resend,
  showLightEmail,
  delete
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
                      if (folderType != FolderType.sent &&
                          folderType != FolderType.drafts)
                        IconButton(
                          icon: Icon(Icons.reply),
                          tooltip: i18n(context, "messages_reply"),
                          onPressed: () => onAppBarActionSelected(
                              MailViewAppBarAction.reply),
                        ),
                      if (folderType != FolderType.sent &&
                          folderType != FolderType.drafts)
                        IconButton(
                          icon: Icon(Icons.reply_all),
                          tooltip: i18n(context, "messages_reply_all"),
                          onPressed: () => onAppBarActionSelected(
                              MailViewAppBarAction.replyToAll),
                        ),
                      if (folderType != FolderType.drafts)
                        IconButton(
                          icon: Icon(MdiIcons.share),
                          tooltip: i18n(context, "messages_forward"),
                          onPressed: () => onAppBarActionSelected(
                              MailViewAppBarAction.forward),
                        ),
//        IconButton(
//          icon: Icon(MdiIcons.themeLightDark),
//          tooltip: i18n(context, "btn_show_email_in_light_theme"),
//          onPressed: () => onAppBarActionSelected(MailViewAppBarAction.showLightEmail),
//        ),
                      IconButton(
                        icon: Icon(Icons.delete_outline),
                        tooltip: i18n(context, "btn_delete"),
                        onPressed: () =>
                            onAppBarActionSelected(MailViewAppBarAction.delete),
                      ),
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return [
                            if (folderType != FolderType.sent &&
                                folderType != FolderType.drafts &&
                                folderType != FolderType.spam)
                              PopupMenuItem(
                                child: InkWell(
                                  child: Text(i18n(context, "btn_to_spam")),
                                  onTap: () {
                                    Navigator.pop(context);
                                    onAppBarActionSelected(
                                        MailViewAppBarAction.toSpam);
                                  },
                                ),
                              ),
                            if (folderType == FolderType.spam)
                              PopupMenuItem(
                                child: InkWell(
                                  child: Text(
                                    i18n(context, "btn_not_spam"),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    onAppBarActionSelected(
                                        MailViewAppBarAction.notSpam);
                                  },
                                ),
                              ),
                            if (folderType == FolderType.sent)
                              PopupMenuItem(
                                child: InkWell(
                                  child: Text(i18n(context, "btn_resend")),
                                  onTap: () {
                                    Navigator.pop(context);
                                    onAppBarActionSelected(
                                        MailViewAppBarAction.resend);
                                  },
                                ),
                              ),
                          ];
                        },
                      ),
                    ],
            );
          }),
    );
  }
}
