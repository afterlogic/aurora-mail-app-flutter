//@dart=2.9
import 'dart:async';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/contacts_bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/events/contacts_event.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
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
      content: Text(S.of(context).hint_vcf_import),
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).btn_cancel),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(S.of(context).btn_vcf_import),
              progress ? CircularProgressIndicator() : SizedBox.shrink(),
            ],
          ),
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
      final result = ErrorToShow(e);
      setState(() => progress = false);
      Navigator.pop(context, result);
    }
  }
}
