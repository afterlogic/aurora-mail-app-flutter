import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class ComposeBody extends StatefulWidget {
  final TextEditingController textCtrl;
  final bool enable;

  const ComposeBody({Key key, @required this.textCtrl, this.enable})
      : super(key: key);

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
    final theme = Theme.of(context);
    return TextField(
      enabled: widget.enable,
      controller: widget.textCtrl,
      maxLines: null,
      minLines: 8,
      focusNode: _focusNode,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 26.0,horizontal: 16),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        fillColor:
            widget.enable ?theme.cardColor : theme.disabledColor.withAlpha(20),
        hintText: i18n(context, "compose_body_placeholder"),
      ),
    );
  }
}
