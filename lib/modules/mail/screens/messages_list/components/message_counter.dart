import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:flutter/material.dart';

class MessageCounterWidget extends StatefulWidget {
  final Folder folder;
  final UpdateMessageCounter messageCounter;

  const MessageCounterWidget(this.messageCounter, this.folder);

  @override
  _MessageCounterWidgetState createState() => _MessageCounterWidgetState();
}

class _MessageCounterWidgetState extends State<MessageCounterWidget> {
  @override
  void initState() {
    super.initState();
    widget.messageCounter.onUpdate = onUpdate;
  }

  onUpdate() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.messageCounter.onUpdate == onUpdate)
      widget.messageCounter.onUpdate = null;
  }

  @override
  Widget build(BuildContext context) {
    final messageCounter = widget.messageCounter;
    if (messageCounter?.folder != null &&
        messageCounter?.folder?.fullNameHash == widget?.folder?.fullNameHash) {
      return Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(5),
        child: Text("${messageCounter.current}/${messageCounter.total}"),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
