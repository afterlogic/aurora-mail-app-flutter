
import 'package:flutter/material.dart';
import 'package:theme/login_form_style.dart';

/// Paints the background behind the whole sign-in flow (login, 2FA, ...).
///
/// The background (flat colour / gradient / image) comes from
/// [LoginFormStyle.screenBackground] on the active theme. Keep it visually in
/// sync with `splashGradientTop/Bottom` in `build_variant.yaml`, which style
/// the native Android splash screen (that one cannot be themed from Dart).
class LoginGradient extends StatelessWidget {
  final Widget? child;

  const LoginGradient({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<LoginFormStyle>() ??
        LoginFormStyle.fallback;

    return Container(
      width: double.infinity,
      decoration: style.screenBackground,
      child: child,
    );
  }
}
