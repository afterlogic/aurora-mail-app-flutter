import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/dialog_wrap.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_state.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_event.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/mail_folder.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoveMessageDialog extends StatefulWidget {
  final List<Message> messages;
  final MessagesListBloc bloc;
  final MailBloc mailBloc;

  MoveMessageDialog(this.messages, this.bloc, this.mailBloc);

  @override
  _MoveMessageDialogState createState() => _MoveMessageDialogState();
}

class _MoveMessageDialogState extends State<MoveMessageDialog>
    with NotSavedChangesMixin {
  List<Folder> stack = [];

  Folder get current {
    if (stack.isEmpty) {
      return null;
    } else {
      return stack.last;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (current == null) {
          return true;
        } else {
          stack.removeLast();
          setState(() {});
          return false;
        }
      },
      child: AlertDialog(
        title: Text(i18n(context, S.label_message_move_to) +
            (current == null ? "" : FolderHelper.getTitle(context, current))),
        content: BlocBuilder<MailBloc, MailState>(
            bloc: BlocProvider.of<MailBloc>(context),
            condition: (prevState, state) =>
                state is FoldersLoaded || state is FoldersEmpty,
            builder: (ctx, state) {
              if (state is FoldersLoaded) {
                return _buildFolders(state);
              } else {
                return SizedBox.shrink();
              }
            }),
        actions: <Widget>[
          FlatButton(
            child: Text(i18n(context, S.btn_message_move)),
            onPressed: current == null ? null : _paste,
          ),
          FlatButton(
            child: Text(
                i18n(context, stack.isNotEmpty ? S.btn_back : S.btn_cancel)),
            onPressed: _cancel,
          ),
        ],
      ),
    );
  }

  Widget _buildFolders(FoldersLoaded state) {
    final currentFolders = state.folders.where((item) {
      if (item.isSubscribed == false) {
        return false;
      }
      final isRoot = item.nameSpace?.isNotEmpty == true &&
          item.fullName.startsWith(item.nameSpace) &&
          item.fullName.allMatches(item.delimiter).length ==
              item.nameSpace.allMatches(item.delimiter).length;
      if (!isRoot && item.parentGuid == current?.guid) {
        return true;
      }
      if (current?.guid == null && isRoot) {
        return true;
      }
      return false;
    }).toList();
    final items =
        List.generate(currentFolders.length, (i) => _folder(currentFolders[i]));
    return SingleChildScrollView(
      child: Column(
        children: items,
      ),
    );
  }

  Widget _folder(Folder folder) {
    return ListTile(
      onTap: () => _addToStack(folder),
      leading: FolderHelper.getIcon(folder),
      title: Text(FolderHelper.getTitle(context, folder)),
    );
  }

  _addToStack(Folder folder) {
    stack.add(folder);
    setState(() {});
  }

  _cancel() {
    if (stack.isNotEmpty) {
      stack.removeLast();
      setState(() {});
    } else {
      stack.clear();
      Navigator.pop(context);
    }
  }

  _paste() {
    final completer = Completer();
    widget.bloc.add(MoveToFolderMessages(widget.messages, current, completer));
    completer.future.then((value) {
      widget.mailBloc.add(RefreshMessages(null));
    });
    Navigator.pop(context, true);
  }
}
