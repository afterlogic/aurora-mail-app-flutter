import 'package:aurora_mail/modules/settings/blocs/notifications/bloc.dart';
import 'package:aurora_mail/notification/push_notifications_manager.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsSettings extends StatefulWidget {
  @override
  _NotificationsSettingsState createState() => _NotificationsSettingsState();
}

class _NotificationsSettingsState extends BState<NotificationsSettings> {
  final bloc = NotificationsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text(i18n(context, S.label_notifications_settings)),
      ),
      body: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            final isProgress = state is ProgressState;
            final tokenStatus = state is InitState ? state.state : null;
            return ListView(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    children: <Widget>[
                      Text(
                        i18n(context, S.label_device_identifier),
                        style: theme.textTheme.subtitle1,
                      ),
                      Expanded(
                          child: Text(
                        PushNotificationsManager.instance.deviceId,
                        textAlign: TextAlign.right,
                      )),
                      IconButton(
                        icon: Icon(Icons.content_copy),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text:
                                  PushNotificationsManager.instance.deviceId));
                          showSnack(
                            isError: false,
                            context: context,
                            scaffoldState: Scaffold.of(context),
                            message: i18n(context,
                                S.label_device_id_copied_to_clip_board),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(i18n(context, S.label_token_storing_status),
                      style: theme.textTheme.subtitle1),
                  trailing: Text(tokenStatus != null
                      ? i18n(
                          context,
                          tokenStatus
                              ? S.label_token_successful
                              : S.label_token_failed)
                      : "..."),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AMButton(
                    isLoading: isProgress,
                    child: Text(i18n(context, S.btn_resend_push_token)),
                    onPressed: () {
                      bloc.add(SendToken());
                    },
                  ),
                )
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
}
