//@dart=2.9
import 'dart:async';
import 'dart:math';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/dialog_wrap.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_state.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_event.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/mail_folder.dart';
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
      child: SafeArea(
        child: AlertDialog(
          title: Text(S.of(context).label_message_move_to),
          content: BlocBuilder<MailBloc, MailState>(
              bloc: widget.mailBloc,
              buildWhen: (prevState, state) =>
                  state is FoldersLoaded || state is FoldersEmpty,
              builder: (ctx, state) {
                if (state is FoldersLoaded) {
                  return _buildFolders(state);
                } else {
                  return SizedBox.shrink();
                }
              }),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).btn_message_move),
              onPressed: current == null ? null : _paste,
            ),
            TextButton(
              child: Text(S.of(context).btn_cancel),
              onPressed: _cancel,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFolders(FoldersLoaded state) {
    final subscribedFolders =
        state.folders.where((e) => e.isSubscribed).toList();
    subscribedFolders.sort((a, b) => a.order - b.order);
    final currentFolders = _sortFolders(subscribedFolders);
    final items =
        List.generate(currentFolders.length, (i) => _folder(currentFolders[i]));
    Widget result = SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items,
      ),
    );
    final depthFolders = Folder.getFoldersDepth(currentFolders);
    if (depthFolders >= 3) {
      result = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: depthFolders * MENU_PADDING_STEP + MENU_ITEM_LENGTH,
          ),
          child: result,
        ),
      );
    }
    return result;
  }

  List<Folder> _sortFolders(List<Folder> folders, [String parentGuid]) {
    List<Folder> result = [];
    final currentLevel = folders.where((item) => item.parentGuid == parentGuid);
    for (final element in currentLevel) {
      result.add(element);
      result.addAll(_sortFolders(folders, element.guid));
    }
    return result;
  }

  Widget _folder(Folder folder) {
    final theme = Theme.of(context);
    var paddingCount = folder.delimiter.allMatches(folder.fullName).length;
    if (folder.nameSpace?.isNotEmpty == true &&
        folder.fullName.startsWith(folder.nameSpace)) {
      paddingCount -= 1;
    }
    paddingCount = max(paddingCount, 0);
    return Padding(
      padding: EdgeInsets.only(left: paddingCount * MENU_PADDING_STEP),
      child: ListTileTheme(
        selectedColor: theme.primaryColor,
        child: ListTile(
          selected: folder == current,
          onTap: () => _addToStack(folder),
          leading: FolderHelper.getIcon(folder),
          title: Text(
            FolderHelper.getTitle(context, folder),
          ),
        ),
      ),
    );
  }

  _addToStack(Folder folder) {
    setState(() {
      stack.clear();
      stack.add(folder);
    });
  }

  _cancel() {
    Navigator.pop(context);
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
