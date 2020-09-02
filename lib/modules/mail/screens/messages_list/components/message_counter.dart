import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/debug/debug_local_storage.dart';
import 'package:flutter/material.dart';

class MessageCounterWidget extends StatefulWidget {
  final Folder folder;
  final UpdateMessageCounter messageCounter;

  const MessageCounterWidget(this.messageCounter, this.folder);

  @override
  _MessageCounterWidgetState createState() => _MessageCounterWidgetState();
}

class _MessageCounterWidgetState extends State<MessageCounterWidget> {
  final _storage = DebugLocalStorage();
  bool _enableCounter;

  @override
  void initState() {
    super.initState();
    widget.messageCounter.onUpdate = onUpdate;
    _storage.getEnableCounter().then((value) {
      _enableCounter = value;
      if (mounted) setState(() {});
    });
  }

  onUpdate() {
    if (mounted) setState(() {});
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
    if (_enableCounter == true &&
        messageCounter?.folder != null &&
        messageCounter?.folder?.fullNameHash == widget?.folder?.fullNameHash) {
      return Container(
        padding: EdgeInsets.all(5),
        child: Text("${messageCounter.current}/${messageCounter.total}"),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
