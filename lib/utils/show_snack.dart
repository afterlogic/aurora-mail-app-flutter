//@dart=2.9
import 'package:aurora_mail/utils/error_to_show.dart';
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
  final error = msg.getString();
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
  if (Theme.of(context) == null || scaffoldState == null) return;
  final theme = Theme.of(context);

  final snack = SnackBar(
          duration: duration,
          content: Text(
            message,
            style: TextStyle(
              color: isError ? Colors.white : theme.scaffoldBackgroundColor
            ),
          ),
          backgroundColor: isError ? theme.colorScheme.error : theme.snackBarTheme.backgroundColor,
          action: action,
        );

  if (message.isEmpty) {
    print("Cannot show empty snack");
  } else {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
