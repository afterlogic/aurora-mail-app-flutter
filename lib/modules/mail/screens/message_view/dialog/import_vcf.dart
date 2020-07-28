import 'dart:async';

import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/contacts_bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/events/contacts_event.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImportVcfDialog extends StatefulWidget {
  final Contact contact;
  final ContactsBloc bloc;

  const ImportVcfDialog({this.contact, this.bloc});

  @override
  _ImportVcfDialogState createState() => _ImportVcfDialogState();
}

class _ImportVcfDialogState extends State<ImportVcfDialog> {
  bool progress = false;

  String getName() {
    if (widget.contact.fullName?.isNotEmpty == true) {
      return widget.contact.fullName;
    }
    if (widget.contact.nickName?.isNotEmpty == true) {
      return widget.contact.nickName;
    }
    return widget.contact.viewEmail ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(i18n(context, "hint_vcf_import", {"name": getName()})),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, "btn_cancel")),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: progress
              ? SizedBox(
                  child: CircularProgressIndicator(),
                )
              : Text(i18n(context, "btn_vcf_import")),
          onPressed: importVcf,
        ),
      ],
    );
  }

  importVcf() async {
    final completer = Completer();
    widget.bloc.add(CreateContact(widget.contact, completer: completer));
    setState(() => progress = true);
    await completer.future;
    setState(() => progress = false);
    Navigator.pop(context);
  }
}
