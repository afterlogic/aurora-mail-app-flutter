import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';

abstract class BState<T extends StatefulWidget> extends State<T> {
  ThemeData theme;

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }
}
