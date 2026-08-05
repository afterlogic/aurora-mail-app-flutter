
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/settings/blocs/notifications/bloc.dart';
import 'package:aurora_mail/notification/push_notifications_manager.dart';
import 'package:aurora_mail/shared_ui/app_bar_icons.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/app_color.dart';

class NotificationsSettings extends StatefulWidget {
  @override
  _NotificationsSettingsState createState() => _NotificationsSettingsState();
}

class _NotificationsSettingsState extends BState<NotificationsSettings> {
  final bloc = NotificationsBloc();

  @override
  Widget build(BuildContext context) {
    final isTablet = LayoutConfig.of(context).isTablet;
    return Scaffold(
      appBar: isTablet
          ? null
          : AMAppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: AppBarIcons.back(context: context),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                S.of(context).label_notifications_settings,
              ),
              shadow: BoxShadow(color: Colors.transparent),
            ),
      body: Column(
        children: [
          if (BuildProperty.useAppBarDivider && !isTablet)
            Container(
              height: 1,
              color: AppColor.appBarDivider,
            ),
          Expanded(
            child: BlocBuilder(
                bloc: bloc,
                builder: (context, dynamic state) {
                  final isProgress = state is ProgressState;
                  final tokenStatus = state is InitState ? state.state : null;
                  Widget button = AMButton(
                    color: AppColor.primaryVariant,
                    shadow: BuildProperty.disableShadowFloatingActionButton
                        ? null
                        : BoxShadow(),
                    isLoading: isProgress,
                    child: Text(S.of(context).btn_resend_push_token,
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      bloc.add(SendToken());
                    },
                  );
                  if (isTablet) {
                    button = Align(
                      alignment: Alignment.centerLeft,
                      child: button,
                    );
                  }
                  return SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'FB token',
                                style: theme.textTheme.titleMedium,
                              ),
                              Expanded(
                                child: Text(
                                  PushNotificationsManager.instance.token ??
                                      "N/A",
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.content_copy),
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: PushNotificationsManager
                                              .instance.token ??
                                          "",
                                    ),
                                  );
                                  showSnack(
                                    isError: false,
                                    context: context,
                                    scaffoldState: Scaffold.of(context),
                                    message: S
                                        .of(context)
                                        .label_device_id_copied_to_clip_board,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                S.of(context).label_device_identifier,
                                style: theme.textTheme.titleMedium,
                              ),
                              Expanded(
                                child: Text(
                                  PushNotificationsManager.instance.deviceId ??
                                      "N/A",
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.content_copy),
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: PushNotificationsManager
                                              .instance.deviceId ??
                                          "",
                                    ),
                                  );
                                  showSnack(
                                    isError: false,
                                    context: context,
                                    scaffoldState: Scaffold.of(context),
                                    message: S
                                        .of(context)
                                        .label_device_id_copied_to_clip_board,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(S.of(context).label_token_storing_status,
                              style: theme.textTheme.titleMedium),
                          trailing: Text(tokenStatus != null
                              ? tokenStatus
                                  ? S.of(context).label_token_successful
                                  : S.of(context).label_token_failed
                              : "..."),
                        ),
                        if (!isTablet) Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: button,
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
}
