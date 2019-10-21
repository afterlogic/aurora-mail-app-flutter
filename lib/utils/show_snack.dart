import 'package:flutter/material.dart';

void showSnack({
  @required BuildContext context,
  @required ScaffoldState scaffoldState,
  @required String msg,
  Duration duration = const Duration(seconds: 5),
  SnackBarAction action,
  isError = true,
}) {
  if (Theme == null || scaffoldState == null) return;

  final theme = Theme.of(context);
  final snack = theme.brightness == Brightness.light
      ? SnackBar(
          duration: duration,
          content: Text(
            msg,
            style: TextStyle(
                color: !isError ? theme.scaffoldBackgroundColor : Colors.white),
          ),
          backgroundColor: isError ? theme.errorColor : null,
          action: action,
        )
      : SnackBar(
          duration: duration,
          content: Text(
            msg,
            style: TextStyle(
                color: !isError ? theme.scaffoldBackgroundColor : Colors.white),
          ),
          backgroundColor: isError ? theme.errorColor : theme.iconTheme.color,
          action: action,
        );

  scaffoldState.removeCurrentSnackBar();
  scaffoldState.showSnackBar(snack);
}
