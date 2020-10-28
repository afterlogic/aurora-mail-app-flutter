import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/components/route_with_finish_callback.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_android.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:flutter/material.dart';

import 'components/message_view_app_bar.dart';

class MessageViewProgress extends StatelessWidget {
  final RouteAnimationListener routeAnimationListener;
  final Future<Message> future;

  const MessageViewProgress(this.future, this.routeAnimationListener);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Message>(
      future: future.catchError((e) {
        Navigator.pop(context, ErrorToShow(e));
      }),
      builder: (context, state) {
        if (state.hasData) {
          return MessageViewAndroid(
            state.data,
            routeAnimationListener,
          );
        } else {
          return Scaffold(
            appBar: MailViewAppBarMock(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
