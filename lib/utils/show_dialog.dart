import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';

Future<T> dialog<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
}) {
  if (Platform.isIOS || true) {
    return showCupertinoDialog(
      context: context,
      builder: builder,
    );
  } else {
    return showDialog(
      context: context,
      builder: builder,
    );
  }
}
