import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/login_gradient.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/mail_logo.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/presentation_header.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/components/am_button.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_color.dart';
import 'package:theme/app_theme.dart';

class UpgradePlanWidget extends StatelessWidget {
  const UpgradePlanWidget();

  Widget _gradientWrap(Widget child) {
    return Theme(
      data: AppTheme.login,
      child: LoginGradient(
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              margin: EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PresentationHeader(),
                  Column(
                    children: <Widget>[
                      Text(
                        i18n(context, "hint_login_upgrade_your_plan"),
                        style: AppTheme.login.textTheme.subhead.copyWith(
                          fontSize: 18
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: AMButton(
                      shadow: AppColor.enableShadow ? null : BoxShadow(),
                      child: Text(i18n(context, "btn_login_back_to_login")),
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
