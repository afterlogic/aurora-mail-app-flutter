//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/login_gradient.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/mail_logo.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/presentation_header.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_theme.dart';
import 'package:aurora_mail/build_property.dart';

class TwoFactorScene extends StatefulWidget {
  final bool isDialog;
  final String logoHint;
  final Widget title;
  final List<Widget> button;
  final bool allowBack;

  const TwoFactorScene({
    Key key,
    this.isDialog,
    this.logoHint,
    this.title,
    this.button,
    this.allowBack = true,
  }) : super(key: key);

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
              title: Text(S.of(context).settings_accounts_add),
              backgroundColor: Color(0xFFF4F1FD),
              textStyle:TextStyle(color: Color(0xFF2D2D2D), fontSize: 18, fontWeight: FontWeight.w600),
              shadow: BoxShadow(color: Colors.transparent),
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
                  mainAxisAlignment: widget.isDialog
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    if (!widget.isDialog) ...[
                      PresentationHeader(
                        message: widget.logoHint,
                      ),
                    ],
                    if (widget.isDialog) SizedBox(height: 40.0),
                    Flexible(
                      flex: 4,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          widget.title ??
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    S.of(context).tfa_label,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            color: AppTheme.loginTextColor),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    S.of(context).tfa_hint_step,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppTheme.loginTextColor),
                                  ),
                                ],
                              ),
                          SizedBox(height: 20),
                          ...widget.button
                        ],
                      ),
                    ),
                    Flexible(
                      child: widget.allowBack
                          ? SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                child: Text(
                                  S.of(context).btn_login_back_to_login,
                                  style:
                                      TextStyle(color: AppTheme.loginTextColor),
                                ),
                                onPressed: () {
                                  Navigator.popUntil(
                                    context,
                                    ModalRoute.withName(LoginRoute.name),
                                  );
                                },
                              ),
                            )
                          : SizedBox.shrink(),
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
