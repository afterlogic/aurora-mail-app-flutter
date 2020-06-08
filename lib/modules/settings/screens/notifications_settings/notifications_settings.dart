import 'package:aurora_mail/modules/mail/screens/messages_list/components/mail_app_bar.dart';
import 'package:aurora_mail/modules/settings/blocs/notifications/bloc.dart';
import 'package:aurora_mail/notification/push_notifications_manager.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsSettings extends StatefulWidget {
  @override
  _NotificationsSettingsState createState() => _NotificationsSettingsState();
}

class _NotificationsSettingsState extends State<NotificationsSettings> {
  final bloc = NotificationsBloc();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

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
                  trailing: Text(PushNotificationsManager.instance.deviceId),
                ),
                ListTile(
                  title: Text(i18n(context, "label_token_storing_status")),
                  trailing: Text(
                      tokenStatus != null ? tokenStatus.toString() : "..."),
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
}
