import 'package:aurora_mail/modules/auth/screens/login/components/login_gradient.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/mail_logo.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/presentation_header.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:theme/app_theme.dart';
import 'package:aurora_mail/build_property.dart';

class TwoFactorScene extends StatefulWidget {
  final bool isDialog;
  final String logoHint;
  final Widget title;
  final Widget button;

  const TwoFactorScene({Key key, this.isDialog, this.logoHint, this.title, this.button})
      : super(key: key);

  @override
  _SelectTwoFactorWidgetState createState() => _SelectTwoFactorWidgetState();
}

class _SelectTwoFactorWidgetState extends BState<TwoFactorScene> {
  Widget _gradientWrap(Widget child) {
    if (widget.isDialog) {
      return child;
    } else {
      return themeWrap(
        LoginGradient(
          child: child,
        ),
      );
    }
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
      appBar: widget.isDialog
          ? AMAppBar(
              title: Text(i18n(context, S.settings_accounts_add)),
            )
          : null,
      body: _gradientWrap(
        _buildPinForm(context),
      ),
    );
  }

  Widget _buildPinForm(BuildContext context) {
    return SafeArea(
      top: false,
      child: Stack(
        children: <Widget>[
          if (!widget.isDialog && !BuildProperty.useMainLogo)
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
                  mainAxisAlignment:
                      widget.isDialog ? MainAxisAlignment.start : MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    if (!widget.isDialog) ...[
                      Flexible(
                        flex: 3,
                        child: PresentationHeader(
                          message: widget.logoHint,
                        ),
                      ),
                    ],
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            i18n(context, S.tfa_label),
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: AppTheme.loginTextColor),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            i18n(context, S.tfa_hint_step),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppTheme.loginTextColor),
                          ),
                        ],
                      ),
                    ),
                    if (widget.isDialog) SizedBox(height: 40.0),
                    Flexible(
                      flex: 4,
                      child: widget.button,
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          child: Text(
                            i18n(context, S.btn_login_back_to_login),
                            style: TextStyle(color: AppTheme.loginTextColor),
                          ),
                          onPressed: () {
                            Navigator.popUntil(
                              context,
                              ModalRoute.withName(LoginRoute.name),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
