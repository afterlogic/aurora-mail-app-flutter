import 'dart:async';

import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/contacts_bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/events/contacts_event.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImportVcfDialog extends StatefulWidget {
  final ContactsBloc bloc;
  final String content;

  const ImportVcfDialog({this.content, this.bloc});

  @override
  _ImportVcfDialogState createState() => _ImportVcfDialogState();
}

class _ImportVcfDialogState extends State<ImportVcfDialog> {
  bool progress = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(i18n(context, "hint_vcf_import")),
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
    widget.bloc.add(ImportVcf(widget.content, completer));
    setState(() => progress = true);
    try {
      await completer.future;
      setState(() => progress = false);
      Navigator.pop(context, "");
    } catch (e) {
      final result = e.toString();
      setState(() => progress = false);
      Navigator.pop(context, result);
    }
  }
}
