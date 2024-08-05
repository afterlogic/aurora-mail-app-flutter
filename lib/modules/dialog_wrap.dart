//@dart=2.9
import 'dart:async';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_event.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/calendar_route.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_view_page.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_android.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:flutter/material.dart';

import 'auth/blocs/auth_bloc/auth_bloc.dart';

class RouteWrap extends StatefulWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navKey;
  static Map<String, dynamic> notification;
  static RouteWrapState staticState;
  final AuthBloc authBloc;

  const RouteWrap({
    Key key,
    this.child,
    this.navKey,
    this.authBloc,
  }) : super(key: key);

  @override
  RouteWrapState createState() => RouteWrapState();
}

class RouteWrapState extends State<RouteWrap> {
  bool hasNotSavedChanges = false;

  @override
  void initState() {
    super.initState();
    RouteWrap.staticState = this;
    if (RouteWrap.notification != null) {
      onMessage(RouteWrap.notification);
      RouteWrap.notification = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (RouteWrap.staticState == this) RouteWrap.staticState = null;
  }

  void showMessage(int userId, int messageUid, int accountLocalId) async {
    if (await discardNotSavedChanges()) {
      final completer = Completer();
      widget.authBloc.add(SelectUser(userId, completer, accountLocalId));
      await completer.future;
      MessagesListAndroid.openMessageLocalId = messageUid;
      widget.navKey.currentState.pushNamedAndRemoveUntil(
        MessagesListRoute.name,
        (_) => false,
        arguments: MessagesListRouteArg(),
      );
    }
  }

  onMessage(Map<String, dynamic> json) {
    if (json.containsKey("To")) {
      return selectUser(json);
    } else {
      //notification from background update
      final userLocalId = json["user"] as int;
      final messageLocalId = json["message"] as int;
      final accountLocalId = json["account"] as int;
      return showMessage(userLocalId, messageLocalId, accountLocalId);
    }
  }

  onCalendar(Map<String, dynamic> json) async {
    final email = json["To"] as String;
    final completer = Completer();

    if (widget.authBloc.currentAccount?.email != email) {
      widget.authBloc.add(SelectUserByEmail(email, completer));
      await completer.future;
    }

    widget.navKey.currentState.pushNamed(
      CalendarRoute.name,
    );
    widget.navKey.currentState.pushNamed(
      EventViewPage.name,
    );
  }

  Future<bool> discardNotSavedChanges() async {
    if (hasNotSavedChanges) {
      final context = widget.navKey.currentState.overlay.context;
      final result = await ConfirmationDialog.show(
        context,
        null,
        S.of(context).label_discard_not_saved_changes,
        S.of(context).btn_discard,
      );
      return result ?? false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void selectUser(Map<String, dynamic> json) async {
    if (await discardNotSavedChanges()) {
      final email = json["To"] as String;
      final completer = Completer();

      if (widget.authBloc.currentAccount?.email != email) {
        widget.authBloc.add(SelectUserByEmail(email, completer));
        await completer.future;
      }
      if (widget.authBloc.currentAccount?.email != email ||
          json["Folder"] as String != null) {
        MessagesListAndroid.openMessageFolder = json["Folder"] as String;
        MessagesListAndroid.openMessageId = json["MessageId"] as String;
        widget.navKey.currentState.pushNamedAndRemoveUntil(
          MessagesListRoute.name,
          (_) => false,
          arguments: MessagesListRouteArg(),
        );
      }
    }
  }
}

mixin NotSavedChangesMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    RouteWrap.staticState?.hasNotSavedChanges = true;
  }

  @override
  void dispose() {
    super.dispose();
    RouteWrap.staticState?.hasNotSavedChanges = false;
  }
}
