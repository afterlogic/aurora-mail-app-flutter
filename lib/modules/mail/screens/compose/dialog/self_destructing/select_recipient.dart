import 'dart:math';

import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class SelectRecipient extends StatefulWidget {
  @override
  _SelectRecipientState createState() => _SelectRecipientState();
}

class _SelectRecipientState extends BState<SelectRecipient> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text(""),
      content: SizedBox(
        height: min(size.height / 2, 350),
        width: min(size.width - 40, 300),
        child: SizedBox.shrink(),
      ),
      actions: [
        FlatButton(
          child: Text(i18n(context, "btn_cancel")),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
