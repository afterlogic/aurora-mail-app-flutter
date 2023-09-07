import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:flutter/material.dart';

class SizedDialogContent extends StatelessWidget {
  final Widget child;

  const SizedDialogContent({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = LayoutConfig.of(context).isTablet;
    final divided = isTablet ? 2 : 2;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / divided,
      height: size.height / divided,
      child: child,
    );
  }
}
