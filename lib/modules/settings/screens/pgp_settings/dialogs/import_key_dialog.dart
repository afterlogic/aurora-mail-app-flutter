import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/dialog_wrap.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/components/key_item.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
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

class PgpKeyForDisplay {
  final PgpKey key;
  final Contact contact;
  bool selected;

  PgpKeyForDisplay(this.key, {this.contact, this.selected = false});

  bool get external => contact != null;

  void toggle() {
    this.selected = !this.selected;
  }
}

class _ImportKeyDialogState extends BState<ImportKeyDialog>
    with NotSavedChangesMixin {
  final List<PgpKeyForDisplay> newKeys = [];
  final List<PgpKeyForDisplay> existedKeys = [];
  final List<PgpKeyForDisplay> externalPrivateKeys = [];

  @override
  void initState() {
    super.initState();
    widget.userKeys.forEach((key, notExist) {
      if (notExist == true) {
        newKeys.add(PgpKeyForDisplay(key, selected: true));
      } else {
        existedKeys.add(PgpKeyForDisplay(key));
      }
    });
    widget.contactKeys.forEach((key, notExist) {
      if (key.isPrivate) {
        externalPrivateKeys
            .add(PgpKeyForDisplay(key.pgpKey, contact: key.contact));
      } else {
        notExist == true
            ? newKeys.add(PgpKeyForDisplay(
                key.pgpKey,
                contact: key.contact,
                selected: true,
              ))
            : existedKeys
                .add(PgpKeyForDisplay(key.pgpKey, contact: key.contact));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final areSelectedKeys =
        newKeys.firstWhere((e) => e.selected == true, orElse: () => null) !=
            null;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (newKeys.isNotEmpty && !BuildProperty.legacyPgpKey)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(i18n(context, S.hint_pgp_keys_for_import)),
                ),
              Column(
                children: newKeys.map((displayKey) {
                  return KeyItem(
                      pgpKey: displayKey.key,
                      external: displayKey.external,
                      selected: displayKey.selected,
                      onSelect: (select) {
                        setState(() {
                          displayKey.toggle();
                        });
                      });
                }).toList(),
              ),
              if (!BuildProperty.legacyPgpKey) ...[
                if (existedKeys.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(i18n(context, S.hint_pgp_existed_keys)),
                  ),
                Column(
                  children: existedKeys.map((displayKey) {
                    return KeyItem(
                      pgpKey: displayKey.key,
                      external: displayKey.external,
                    );
                  }).toList(),
                ),
                if (externalPrivateKeys.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(i18n(context, S.hint_pgp_external_private_keys)),
                  ),
                Column(
                  children: externalPrivateKeys.map((displayKey) {
                    return KeyItem(
                      pgpKey: displayKey.key,
                      external: displayKey.external,
                    );
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(i18n(context, S.btn_pgp_import_selected_key)),
                state is ImportProgress
                    ? CircularProgressIndicator()
                    : SizedBox.shrink(),
              ],
            ),
            onPressed:
                areSelectedKeys && state is! ImportProgress ? _import : null,
          ),
        ),
      ],
    );
  }

  _import() {
    final Map<PgpKey, bool> userKeys = {};
    final Map<PgpKeyWithContact, bool> contactKeys = {};
    final selected = newKeys.where((e) => e.selected);
    selected.forEach((displayKey) {
      if (displayKey.external) {
        final key = PgpKeyWithContact(displayKey.key, displayKey.contact);
        contactKeys[key] = true;
      } else {
        final key = displayKey.key;
        userKeys[key] = true;
      }
    });
    widget.bloc.add(
      ImportKey(
        userKeys,
        contactKeys,
      ),
    );
  }
}
