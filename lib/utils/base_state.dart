//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BState<T extends StatefulWidget> extends State<T> {
  ThemeData theme;

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }
}
