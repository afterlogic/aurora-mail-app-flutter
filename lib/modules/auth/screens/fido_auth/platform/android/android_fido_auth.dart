import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/login_gradient.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/mail_logo.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/presentation_header.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/components/am_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_color.dart';
import 'package:theme/app_theme.dart';

class AndroidFidoAuth extends StatefulWidget {
  @override
  _AndroidFidoAuthState createState() => _AndroidFidoAuthState();
}

class _AndroidFidoAuthState extends State<AndroidFidoAuth> {
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
                            "Android FIDO doesn't support yet",
                            style: Theme.of(context).textTheme.subhead.copyWith(
                                fontSize: 18, color: AppTheme.loginTextColor),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
