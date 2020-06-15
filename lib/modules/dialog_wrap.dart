import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class RouteWrap extends StatefulWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navKey;
  static RouteWrapState staticState;

  const RouteWrap({
    Key key,
    this.child,
    this.navKey,
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
  }

  @override
  void dispose() {
    super.dispose();
    RouteWrap.staticState = null;
  }

  void showMessage(int localId) async {
    if (await discardNotSavedChanges()) {
      Navigator.of(widget.navKey.currentState.overlay.context)
          .pushNamedAndRemoveUntil(
        MessagesListRoute.name,
        (_) => false,
        arguments: MessagesListRouteArg(messageLocalId: localId),
      );
    }
  }

  Future<bool> discardNotSavedChanges() async {
    if (hasNotSavedChanges) {
      final result = await ConfirmationDialog.show(
        widget.navKey.currentState.overlay.context,
        null,
        i18n(context, "label_discard_not_saved_changes"),
        i18n(context, "btn_discard"),
      );
      return result ?? false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
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
