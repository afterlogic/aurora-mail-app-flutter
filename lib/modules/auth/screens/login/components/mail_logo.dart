import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';

class MailLogo extends StatelessWidget {
  final bool isBackground;
  final double scale;

  const MailLogo({this.isBackground = false, this.scale = 1.0});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = (isBackground ? 350.0 : 52.0) * scale;

    if (BuildProperty.useMainLogo) {
      final logo = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Align(
          alignment: Alignment.center,
          widthFactor: 1.0,
          heightFactor: 0.4,
          child: Image.asset(BuildProperty.main_logo),
        ),
      );
      return scale == 1.0 ? logo : Transform.scale(scale: scale, child: logo);
    } else {
      return Opacity(
        opacity: isBackground ? 0.05 : 1.0,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(500.0),
          ),
          child: Icon(Icons.alternate_email,
              size: (isBackground ? 240.0 : 32.0) * scale,
              color: Colors.white),
        ),
      );
    }
  }
}
