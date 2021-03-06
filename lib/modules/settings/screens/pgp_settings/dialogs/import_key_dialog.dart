import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/modules/dialog_wrap.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/components/key_item.dart';
import 'package:aurora_mail/shared_ui/sized_dialog_content.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart'; import 'package:aurora_mail/res/str/s.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImportKeyDialog extends StatefulWidget {
  final Map<PgpKey, bool> userKeys;
  final Map<PgpKeyWithContact, bool> contactKeys;
  final PgpSettingsBloc bloc;

  const ImportKeyDialog(
    this.userKeys,
    this.contactKeys,
    this.bloc,
  );

  @override
  _ImportKeyDialogState createState() => _ImportKeyDialogState();
}

class _ImportKeyDialogState extends BState<ImportKeyDialog> with NotSavedChangesMixin{
  final List<PgpKey> userKeys = [];
  final List<PgpKeyWithContact> contactKeys = [];
  final List<PgpKeyWithContact> newContactKeys = [];
  bool keyAlreadyExist = false;

  @override
  void initState() {
    super.initState();
    widget.userKeys.forEach((key, value) {
      userKeys.add(key);
      if (value == null) {
        keyAlreadyExist = true;
      }
    });
    widget.contactKeys.forEach((key, value) {
      if (key.contact == null) {
        newContactKeys.add(key);
      } else {
        contactKeys.add(key);
      }
      if (value == null) {
        keyAlreadyExist = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(i18n(context, S.label_pgp_import_key)),
      content: BlocListener(
        bloc: widget.bloc,
        listener: (BuildContext context, state) {
          if (state is ImportComplete) {
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: <Widget>[
              if (keyAlreadyExist)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(i18n(context, S.hint_pgp_already_have_keys)),
                ),
              if (userKeys.isNotEmpty && !BuildProperty.legacyPgpKey)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(i18n(context, S.hint_pgp_your_keys)),
                ),
              Column(
                children: userKeys.map((key) {
                  return KeyItem(key, widget.userKeys[key], (select) {
                    widget.userKeys[key] = select;
                    setState(() {});
                  });
                }).toList(),
              ),
              if (!BuildProperty.legacyPgpKey) ...[
                if (contactKeys.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(i18n(
                        context, S.hint_pgp_keys_will_be_import_to_contacts)),
                  ),
                Column(
                  children: contactKeys.map((key) {
                    return KeyItem(key, widget.contactKeys[key], (select) {
                      widget.contactKeys[key] = select;
                      setState(() {});
                    });
                  }).toList(),
                ),
                if (newContactKeys.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(i18n(
                        context, S.hint_pgp_keys_contacts_will_be_created)),
                  ),
                Column(
                  children: newContactKeys.map((key) {
                    return KeyItem(key, widget.contactKeys[key], (select) {
                      widget.contactKeys[key] = select;
                      setState(() {});
                    });
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, S.btn_cancel)),
          onPressed: () => Navigator.pop(context),
        ),
        BlocBuilder(
          bloc: widget.bloc,
          builder: (context, state) => FlatButton(
            child: state is! ImportProgress
                ? Text(i18n(context, S.btn_pgp_import_selected_key))
                : CircularProgressIndicator(),
            onPressed: state is! ImportProgress ? _import : null,
          ),
        ),
      ],
    );
  }

  _import() {
    widget.bloc.add(
      ImportKey(
        widget.userKeys,
        widget.contactKeys,
      ),
    );
  }
}
