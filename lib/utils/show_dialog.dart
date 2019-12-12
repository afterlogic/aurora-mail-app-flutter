import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future dialog({
  @required BuildContext context,
  @required WidgetBuilder builder,
}) {
  if (Platform.isIOS) {
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
