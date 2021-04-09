import 'dart:io';
import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/debug/debug_local_storage.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebugSetting extends StatefulWidget {
  @override
  _DebugSettingState createState() => _DebugSettingState();
}

class _DebugSettingState extends BState<DebugSetting> {
  final _storage = DebugLocalStorage();
  bool _messageCounter;
  bool _backgroundRecord;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    Future.wait([
      _storage.getBackgroundRecord(),
      _storage.getEnableCounter(),
    ]).then((value) {
      _backgroundRecord = (value[0] ?? false);
      _messageCounter = (value[1] ?? false);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = LayoutConfig.of(context).isTablet;
    return Scaffold(
      appBar: isTablet
          ? null
          : AMAppBar(
              title: Text("Debug"),
            ),
      body: _backgroundRecord == null
          ? SizedBox.shrink()
          : Column(
              children: <Widget>[
                CheckboxListTile(
                  value: _backgroundRecord,
                  title: Text(i18n(context, S.label_record_log_in_background)),
                  onChanged: (bool value) {
                    _backgroundRecord = value;
                    _storage.setBackgroundRecord(value);
                    setState(() {});
                  },
                ),
                CheckboxListTile(
                  value: _messageCounter,
                  title: Text(
                      i18n(context, S.label_enable_uploaded_message_counter)),
                  onChanged: (bool value) {
                    _messageCounter = value;
                    _storage.setEnableCounter(value);
                    setState(() {});
                  },
                ),
                Expanded(
                  child: LoggerSettingWidget(
                    LoggerSettingArg(
                        BlocProvider.of<AuthBloc>(context).currentUser.hostname,
                        i18n(context, S.label_show_debug_view),
                        i18n(context, S.btn_log_delete_all),
                        i18n(context, S.hint_log_delete_all),
                        i18n(context, S.debug_hint_log_delete_record),
                        (hint) async {
                      final result = await AMConfirmationDialog.show(
                        context,
                        "",
                        hint,
                        i18n(context, S.btn_delete),
                        i18n(context, S.btn_cancel),
                      );
                      if (result == true) {
                        return true;
                      } else {
                        return false;
                      }
                    }),
                  ),
                ),
              ],
            ),
    );
  }
}
