
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/screens/configure_two_factor/configure_two_factor_route.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/login_gradient.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/mail_logo.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/presentation_header.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:aurora_ui_kit/components/am_button.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfigureTwoFactorScreen extends StatelessWidget {
  final ConfigureTwoFactorRouteArgs? args;

  const ConfigureTwoFactorScreen({this.args, Key? key}) : super(key: key);

  Widget _gradientWrap(Widget child) {
    return themeWrap(
      LoginGradient(
        child: child,
      ),
    );
  }

  Widget themeWrap(Widget child) {
    if (AppTheme.login != null) {
      return Theme(
        data: AppTheme.login!,
        child: child,
      );
    }
    return child;
  }

  Future<void> _onButtonTap(BuildContext context) async {
    final webUrl = args!.webVersionUrl;
    if (webUrl.isNotEmpty) {
      launchUrl(Uri.parse(webUrl));
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonLabel = args!.webVersionUrl.isNotEmpty
        ? S.of(context).btn_login_open_web_version
        : S.of(context).btn_login_back_to_login;

    return Scaffold(
      body: _gradientWrap(
        Stack(
          children: <Widget>[
            if (!BuildProperty.useMainLogo)
              Positioned(
                top: -70.0,
                left: -70.0,
                child: MailLogo(isBackground: true),
              ),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: LayoutConfig.formWidth,
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      PresentationHeader(),
                      Column(
                        children: <Widget>[
                          Text(
                            S.of(context).hint_login_configure_2FA,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: 18,
                                    color: AppTheme.loginTextColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: AMButton(
                          color: const Color(0xFF3975B5),
                          radius: BorderRadius.circular(10.0),
                          shadow:
                              BuildProperty.disableShadowFloatingActionButton
                                  ? null
                                  : const BoxShadow(),
                          child: Text(
                            buttonLabel,
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () => _onButtonTap(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
