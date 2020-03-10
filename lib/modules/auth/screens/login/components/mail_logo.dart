import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';

class MailLogo extends StatelessWidget {
  final bool isBackground;

  const MailLogo({this.isBackground = false});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    final size = isBackground ? 350.0 : 52.0;

    if (BuildProperty.useMainLogo) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Image.asset(BuildProperty.main_logo),
      );
    } else {
      return Opacity(
        opacity: isBackground ? 0.05 : 1.0,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: theme.accentColor,
            borderRadius: BorderRadius.circular(500.0),
          ),
          child: Icon(Icons.alternate_email,
              size: isBackground ? 240.0 : 32.0, color: Colors.white),
        ),
      );
    }
  }
}
