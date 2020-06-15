import 'package:aurora_mail/modules/mail/screens/messages_list/components/mail_app_bar.dart';
import 'package:aurora_mail/modules/settings/blocs/notifications/bloc.dart';
import 'package:aurora_mail/notification/push_notifications_manager.dart';
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

class _NotificationsSettingsState extends State<NotificationsSettings> {
  final bloc = NotificationsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text(i18n(context, "label_notifications_settings")),
      ),
      body: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            final isProgress = state is ProgressState;
            final tokenStatus = state is InitState ? state.state : null;
            return ListView(
              children: <Widget>[
                ListTile(
                  title: Text(i18n(context, "label_device_identifier")),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(PushNotificationsManager.instance.deviceId),
                      IconButton(
                        icon: Icon(Icons.content_copy),
                        onPressed: (){
                          Clipboard.setData(ClipboardData(text: PushNotificationsManager.instance.deviceId));
                          showSnack(context: context, scaffoldState: Scaffold.of(context), msg: "label_device_id_copied_to_clip_board");
                        },
                      )
                    ],
                  ),
                ),
                ListTile(
                  title: Text(i18n(context, "label_token_storing_status")),
                  trailing: Text(tokenStatus != null
                      ? i18n(
                          context,
                          tokenStatus
                              ? "label_token_successful"
                              : "label_token_failed")
                      : "..."),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AMButton(
                    isLoading: isProgress,
                    child: Text(i18n(context, "btn_resend_push_token")),
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
