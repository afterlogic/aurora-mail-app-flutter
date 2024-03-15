//@dart=2.9
import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/debug/debug_local_storage.dart';
import 'package:aurora_mail/utils/base_state.dart';
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
  bool _showResponseBody;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    Future.wait([
      _storage.getBackgroundRecord(),
      _storage.getEnableCounter(),
      _storage.getShowResponseBody(),
    ]).then((value) {
      setState(() {
        _backgroundRecord = (value[0] ?? false);
        _messageCounter = (value[1] ?? false);
        _showResponseBody = (value[2] ?? false);
      });
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
                  title: Text(S.of(context).label_record_log_in_background),
                  onChanged: (bool value) {
                    _backgroundRecord = value;
                    _storage.setBackgroundRecord(value);
                    setState(() {});
                  },
                ),
                CheckboxListTile(
                  value: _messageCounter,
                  title: Text(
                      S.of(context).label_enable_uploaded_message_counter),
                  onChanged: (bool value) {
                    _messageCounter = value;
                    _storage.setEnableCounter(value);
                    setState(() {});
                  },
                ),
                CheckboxListTile(
                  value: _showResponseBody,
                  title: Text('Show response body'),
                  onChanged: (bool value) {
                    setState(() {
                      _showResponseBody = value;
                      _storage.setShowResponseBody(value);
                    });
                  },
                ),
                Expanded(
                  child: LoggerSettingWidget(
                    LoggerSettingArg(
                        BlocProvider.of<AuthBloc>(context).currentUser.hostname,
                        S.of(context).label_show_debug_view,
                        S.of(context).btn_log_delete_all,
                        S.of(context).hint_log_delete_all,
                        S.of(context).debug_hint_log_delete_record,
                        (hint) async {
                      final result = await AMConfirmationDialog.show(
                        context,
                        "",
                        hint,
                        S.of(context).btn_delete,
                        S.of(context).btn_cancel,
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
