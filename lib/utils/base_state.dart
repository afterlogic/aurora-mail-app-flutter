
import 'package:flutter/material.dart';

abstract class BState<T extends StatefulWidget> extends State<T> {
  late ThemeData theme;

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }
}
