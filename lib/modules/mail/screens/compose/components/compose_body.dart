import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ComposeBody extends StatefulWidget {
  final TextEditingController textCtrl;
  final FocusNode focusNode;
  final bool enable;

  const ComposeBody(
      {Key key, @required this.textCtrl, this.focusNode, this.enable})
      : super(key: key);

  @override
  _ComposeBodyState createState() => _ComposeBodyState();
}

class _ComposeBodyState extends BState<ComposeBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enable,
      controller: widget.textCtrl,
      maxLines: null,
      minLines: 8,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 26.0, horizontal: 16),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        fillColor:
            widget.enable ? theme.cardColor : theme.disabledColor.withAlpha(20),
        hintText: i18n(context, "compose_body_placeholder"),
      ),
    );
  }
}
