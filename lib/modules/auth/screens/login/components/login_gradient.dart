//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';

class LoginGradient extends StatelessWidget {
  final Widget child;

  const LoginGradient({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.5, 1],
          colors: [
            _fromHex(isDark ? BuildProperty.splashGradientTopDark : BuildProperty.splashGradientTop),
            _fromHex(isDark ? BuildProperty.splashGradientCenterDark : BuildProperty.splashGradientCenter),
            _fromHex(isDark ? BuildProperty.splashGradientBottomDark : BuildProperty.splashGradientBottom),
          ],
        ),
      ),
      child: child,
    );
  }

  Color _fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
