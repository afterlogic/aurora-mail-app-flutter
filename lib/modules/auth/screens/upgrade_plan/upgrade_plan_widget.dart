import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/modules/app_config/app_config.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/login_gradient.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/mail_logo.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/presentation_header.dart';
import 'package:aurora_mail/utils/internationalization.dart'; import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_ui_kit/components/am_button.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_color.dart';
import 'package:theme/app_theme.dart';

class UpgradePlanWidget extends StatelessWidget {
  final String message;

  const UpgradePlanWidget(this.message);

  Widget _gradientWrap(Widget child) {
    return themeWrap(
      LoginGradient(
        child: child,
      ),
    );
  }

  Widget themeWrap(Widget widget) {
    if (AppTheme.login != null) {
      return Theme(
        data: AppTheme.login,
        child: widget,
      );
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = AppConfig.of(context).isTablet;
    final media = MediaQuery.of(context);
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
            Container(
              padding: isTablet
                  ? EdgeInsets.symmetric(horizontal: media.size.width / 6)
                  : null,
              margin: EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PresentationHeader(),
                  Column(
                    children: <Widget>[
                      Text(
                        message ??
                            i18n(context, S.hint_login_upgrade_your_plan),
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: AMButton(
                      shadow: AppColor.enableShadow ? null : BoxShadow(),
                      child: Text(i18n(context, S.btn_login_back_to_login)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
