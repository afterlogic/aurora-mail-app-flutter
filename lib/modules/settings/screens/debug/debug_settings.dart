import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/logger/logger.dart';
import 'package:aurora_mail/models/alias_or_identity.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/debug/debug_local_storage.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/generate_key_dialog.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/import_from_text_dialog.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/import_key_dialog.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/screens/pgp_key_route.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/screens/pgp_keys_route.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:crypto_model/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebugSetting extends StatefulWidget {
  @override
  _DebugSettingState createState() => _DebugSettingState();
}

class _DebugSettingState extends BState<DebugSetting> {
  final _storage = DebugLocalStorage();
  bool _debug;

  @override
  void initState() {
    super.initState();
    _storage.getDebug().then((value) {
      _debug = value ?? false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text("Debug"),
      ),
      body: _debug == null
          ? SizedBox.shrink()
          : ListView(
              children: <Widget>[
                CheckboxListTile(
                  value: _debug,
                  title: Text("Show debug view"),
                  onChanged: (bool value) {
                    _debug = value;
                    _storage.setDebug(value);
                    setState(() {});
                    logger.enable = value;
                  },
                ),
              ],
            ),
    );
  }
}
