import 'package:aurora_mail/utils/errors_enum.dart';
import 'package:flutter/material.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

void showSnack({
  @required BuildContext context,
  @required ScaffoldState scaffoldState,
  @required dynamic msg,
  Duration duration = const Duration(seconds: 5),
  SnackBarAction action,
  isError = true,
}) {
  if (Theme == null || scaffoldState == null) return;
  final errorMessage =
      msg is WebMailError ? getErrTranslation(context, msg) : msg.toString();

  final theme = Theme.of(context);
  final snack = theme.brightness == Brightness.light
      ? SnackBar(
          duration: duration,
          content: Text(
            errorMessage,
            style: TextStyle(
                color: !isError ? theme.scaffoldBackgroundColor : Colors.white),
          ),
          backgroundColor: isError ? theme.errorColor : null,
          action: action,
        )
      : SnackBar(
          duration: duration,
          content: Text(
            errorMessage,
            style: TextStyle(
                color: !isError ? theme.scaffoldBackgroundColor : Colors.white),
          ),
          backgroundColor: isError ? theme.errorColor : theme.iconTheme.color,
          action: action,
        );

  if (errorMessage.isEmpty) {
    print("Cannot show empty snack");
  } else {
    scaffoldState.removeCurrentSnackBar();
    scaffoldState.showSnackBar(snack);
  }
}
