import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

void showErrorSnack({
  @required BuildContext context,
  @required ScaffoldState scaffoldState,
  @required ErrorToShow msg,
  Map<String, String> arg,
  Duration duration = const Duration(seconds: 5),
  SnackBarAction action,
  bool isError = true,
}) {
  final error = msg.getString(context, arg);
  return showSnack(
    context: context,
    scaffoldState: scaffoldState,
    message: error,
    duration: duration,
    action: action,
    isError: isError,
  );
}

void showSnack({
  @required BuildContext context,
  @required ScaffoldState scaffoldState,
  @required String message,
  Duration duration = const Duration(seconds: 5),
  SnackBarAction action,
  bool isError = true,
}) {
  if (Theme == null || scaffoldState == null) return;
  final theme = Theme.of(context);

  final snack = theme.brightness == Brightness.light
      ? SnackBar(
          duration: duration,
          content: Text(
            message,
            style: TextStyle(
                color: !isError ? theme.scaffoldBackgroundColor : Colors.white),
          ),
          backgroundColor: isError ? theme.errorColor : null,
          action: action,
        )
      : SnackBar(
          duration: duration,
          content: Text(
            message,
            style: TextStyle(
                color: !isError ? theme.scaffoldBackgroundColor : Colors.white),
          ),
          backgroundColor: isError ? theme.errorColor : theme.iconTheme.color,
          action: action,
        );

  if (message.isEmpty) {
    print("Cannot show empty snack");
  } else {
    scaffoldState.removeCurrentSnackBar();
    scaffoldState.showSnackBar(snack);
  }
}
