import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';

class LoginGradient extends StatelessWidget {
  final Widget child;

  const LoginGradient({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0, 1],
          colors: [
            _fromHex(BuildProperty.splashGradientTop),
            _fromHex(BuildProperty.splashGradientBottom),
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
