import 'dart:math';

import 'package:aurora_mail/shared_ui/toast_widget.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

import 'components/clipboard_label.dart';
import 'components/contact_with_key_widget.dart';
import 'model/contact_with_key.dart';

class ViewPassword extends StatelessWidget {
  final List<ContactWithKey> contacts;
  final String password;
  final toastKey = GlobalKey<ToastWidgetState>();

  ViewPassword(this.contacts, this.password);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text(i18n(context, "send_self_destructing_title")),
      content: SizedBox(
        height: min(size.height / 2, 350),
        width: min(size.width - 40, 300),
        child: Row(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Text(
                  i18n(context, "supports_plain_text_only"),
                  style: theme.textTheme.caption,
                ),
                SizedBox(height: 20),
                Column(
                  children: contacts
                      .map((item) => ContactWithKeyWidget(item))
                      .toList(),
                ),
                SizedBox(height: 20),
                ClipboardLabel(password, "Encrypted message password.", () {
              toastKey.currentState.show("link_coppied_to_clipboard");
                }),
                SizedBox(height: 20),
                Text(
                  i18n(context, "sent_password_using_different_channel"),
                  style: theme.textTheme.caption,
                ),
              ],
            ),
            Center(
              child: ToastWidget(
                key: toastKey,
              ),
            )
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
