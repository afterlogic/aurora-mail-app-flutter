//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_color.dart';

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
      textCapitalization: TextCapitalization.sentences,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        filled: true,
        fillColor: AppColor.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: AppColor.inputBorder,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: AppColor.inputBorder,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: AppColor.inputBorder,
            width: 1.0,
          ),
        ),
        hintText: S.of(context).compose_body_placeholder,
        hintStyle: TextStyle(
          color: AppColor.inputPlaceholder,
        ),
      ),
    );
  }
}
