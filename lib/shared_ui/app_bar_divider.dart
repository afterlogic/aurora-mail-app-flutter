import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_color.dart';

/// Utility function for adding divider under AppBar
/// only for the unlyme build
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

/// Utility function for getting Column with divider
/// it is used when the AppBar is embedded in a Column instead of a Scaffold.
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
