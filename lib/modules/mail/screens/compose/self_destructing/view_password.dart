import 'dart:math';

import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

import 'components/clipboard_label.dart';
import 'components/contact_with_key_widget.dart';
import 'model/contact_with_key.dart';

class ViewPassword extends StatelessWidget {
  final List<ContactWithKey> contacts;
  final String password;

  const ViewPassword(this.contacts, this.password);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text(i18n(context, "send_self_destructing_title")),
      content: SizedBox(
        height: min(size.height / 2, 350),
        width: min(size.width - 40, 300),
        child: ListView(
          children: <Widget>[
            Text(
              "OpenPGP supports plain text only. Click OK to remove all the formatting and continue. Also, attachments cannot be encrypted or signed.",
              style: theme.textTheme.caption,
            ),
            SizedBox(height: 20),
            Column(
              children: contacts.map((item) => ContactWithKeyWidget(item)).toList(),
            ),
            ClipboardLabel(password, "Encrypted message password.", () {
//              toastKey.currentState.show(s.link_coppied_to_clipboard);
            }),
            SizedBox(height: 20),
            Text(
              "The password must be sent using a different channel.  Store the password somewhere. You will not be able to recover it otherwise.",
              style: theme.textTheme.caption,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, "btn_cancel")),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text(i18n(context, "ok")),
          onPressed: () => Navigator.pop(context, true),
        )
      ],
    );
  }
}
