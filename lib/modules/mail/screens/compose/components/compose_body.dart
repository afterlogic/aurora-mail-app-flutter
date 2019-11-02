import 'package:flutter/material.dart';

class ComposeBody extends StatefulWidget {
  final TextEditingController textCtrl;

  const ComposeBody({Key key, @required this.textCtrl}) : super(key: key);

  @override
  _ComposeBodyState createState() => _ComposeBodyState();
}

class _ComposeBodyState extends State<ComposeBody> {
  var _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      focusNode: _focusNode,
      controller: widget.textCtrl,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 26.0),
        border: InputBorder.none,
        hintText: "Message text...",
      ),
    );
  }
}
