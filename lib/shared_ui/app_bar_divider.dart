import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_color.dart';

/// Утилитная функция для добавления divider под AppBar
/// только для билда unlyme
Widget buildAppBarWithDivider({
  required PreferredSizeWidget appBar,
  required Widget body,
}) {
  if (!BuildProperty.useAppBarDivider) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

  return Scaffold(
    appBar: appBar,
    body: Column(
      children: [
        Container(
          height: 1,
          color: AppColor.appBarDivider,
        ),
        Expanded(child: body),
      ],
    ),
  );
}

/// Утилитная функция для получения Column с divider
/// используется когда AppBar встроен в Column вместо Scaffold
Widget buildBodyWithAppBarDivider({required Widget body}) {
  if (!BuildProperty.useAppBarDivider) {
    return body;
  }

  return Column(
    children: [
      Container(
        height: 1,
        color: AppColor.appBarDivider,
      ),
      Expanded(child: body),
    ],
  );
}
