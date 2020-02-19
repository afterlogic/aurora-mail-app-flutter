import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class ComposeBody extends StatefulWidget {
  final TextEditingController textCtrl;
  final FocusNode focusNode;

  const ComposeBody({
    Key key,
    @required this.textCtrl,
    this.focusNode,
  }) : super(key: key);

  @override
  _ComposeBodyState createState() => _ComposeBodyState();
}

class _ComposeBodyState extends State<ComposeBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textCtrl,
      maxLines: null,
      minLines: 8,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 26.0),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        fillColor: Theme.of(context).cardColor,
        hintText: i18n(context, "compose_body_placeholder"),
      ),
    );
  }
}
