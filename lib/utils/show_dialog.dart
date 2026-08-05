
import 'package:flutter/cupertino.dart';

Future<T?> dialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  return showCupertinoDialog(
    context: context,
    builder: builder,
  );
}
