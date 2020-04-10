import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/mail_folder.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoveMessage extends StatefulWidget {
  final List<Message> messages;
  final MessagesListBloc bloc;

  MoveMessage(this.messages, this.bloc);

  @override
  State<StatefulWidget> createState() => MoveMessageState();
}

class MoveMessageState extends State<MoveMessage> {
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
      child: Scaffold(
        appBar: AppBar(
          title: Text(i18n(context, "move_to") +
              (current == null ? "" : FolderHelper.getTitle(context, current))),
        ),
        body: BlocBuilder<MailBloc, MailState>(
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
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Divider(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Text(i18n(context, "paste")),
                  onPressed: current == null ? null : _paste,
                ),
                FlatButton(
                  child: Text(i18n(context, "btn_cancel")),
                  onPressed: _cancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFolders(FoldersLoaded state) {
    final currentFolders = state.folders
        .where((item) => item.parentGuid == current?.guid)
        .toList();
    return ListView.builder(
      itemCount: currentFolders.length,
      itemBuilder: (context, i) => _folder(currentFolders[i]),
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
    stack.clear();
    Navigator.pop(context);
  }

  _paste() {
    widget.bloc.add(MoveToFolderMessages(widget.messages, current));
    _cancel();
  }
}
