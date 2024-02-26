//@dart=2.9
import 'dart:math';

import 'package:aurora_mail/modules/dialog_wrap.dart';
import 'package:aurora_mail/shared_ui/toast_widget.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/material.dart';

import 'components/clipboard_label.dart';
import 'components/contact_with_key_widget.dart';
import 'model/contact_with_key.dart';

class ViewPassword extends StatefulWidget {
  final List<ContactWithKey> contacts;
  final String password;

  ViewPassword(this.contacts, this.password);

  @override
  _ViewPasswordState createState() => _ViewPasswordState();
}

class _ViewPasswordState extends State<ViewPassword> with NotSavedChangesMixin {
  final toastKey = GlobalKey<ToastWidgetState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text(i18n(context, S.label_self_destructing)),
      content: SizedBox(
        height: min(size.height / 2, 350),
        width: min(size.width - 40, 300),
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Text(
                  i18n(context,
                      S.hint_self_destructing_supports_plain_text_only),
                  style: theme.textTheme.caption,
                ),
                SizedBox(height: 20),
                Column(
                  children: widget.contacts
                      .map((item) => ContactWithKeyWidget(item))
                      .toList(),
                ),
                SizedBox(height: 20),
                ClipboardLabel(widget.password, "Encrypted message password.",
                    () {
                  toastKey.currentState.show(i18n(context,
                      S.hint_self_destructing_password_coppied_to_clipboard));
                }),
                SizedBox(height: 20),
                Text(
                  i18n(context,
                      S.hint_self_destructing_sent_password_using_different_channel),
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
        TextButton(
          child: Text(i18n(context, S.btn_cancel)),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(i18n(context, S.btn_ok)),
          onPressed: () => Navigator.pop(context, true),
        )
      ],
    );
  }
}
