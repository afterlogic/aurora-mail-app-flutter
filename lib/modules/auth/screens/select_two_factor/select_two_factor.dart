import 'package:aurora_mail/modules/auth/screens/backup_code_auth/backup_code_auth_route.dart';
import 'package:aurora_mail/modules/auth/screens/component/two_factor_screen.dart';
import 'package:aurora_mail/modules/auth/screens/fido_auth/fido_auth_route.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/auth/screens/select_two_factor/select_two_factor_route.dart';
import 'package:aurora_mail/modules/auth/screens/two_factor_auth/two_factor_auth_route.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/login_gradient.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/mail_logo.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/presentation_header.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/components/am_button.dart';
import 'package:theme/app_theme.dart';

class SelectTwoFactorWidget extends StatefulWidget {
  final SelectTwoFactorRouteArgs args;

  const SelectTwoFactorWidget({Key key, this.args}) : super(key: key);

  @override
  _SelectTwoFactorWidgetState createState() => _SelectTwoFactorWidgetState();
}

class _SelectTwoFactorWidgetState extends BState<SelectTwoFactorWidget> {
  @override
  Widget build(BuildContext context) {
    return TwoFactorScene(
      logoHint: "",
      isDialog: widget.args.isDialog,
      button: [
        Text(
          i18n(context, S.tfa_label_hint_security_options),
          style: TextStyle(color: AppTheme.loginTextColor),
        ),
        SizedBox(height: 20),
        if (widget.args.state.hasSecurityKey) ...[
          SizedBox(
            width: double.infinity,
            child: AMButton(
              child: Text(
                i18n(context, S.tfa_btn_use_security_key),
                style: TextStyle(color: AppTheme.loginTextColor),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  FidoAuthRoute.name,
                  ModalRoute.withName(LoginRoute.name),
                  arguments: FidoAuthRouteArgs(widget.args.isDialog,
                      widget.args.authBloc, widget.args.state),
                );
              },
            ),
          ),
          SizedBox(height: 20)
        ],
        if (widget.args.state.hasAuthenticatorApp) ...[
          SizedBox(
            width: double.infinity,
            child: AMButton(
              child: Text(
                i18n(context, S.tfa_btn_use_auth_app),
                style: TextStyle(color: AppTheme.loginTextColor),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  TwoFactorAuthRoute.name,
                  ModalRoute.withName(LoginRoute.name),
                  arguments: TwoFactorAuthRouteArgs(widget.args.isDialog,
                      widget.args.authBloc, widget.args.state),
                );
              },
            ),
          ),
          SizedBox(height: 20)
        ],
        if (widget.args.state.hasBackupCodes) ...[
          SizedBox(
            width: double.infinity,
            child: AMButton(
              child: Text(
                i18n(context, S.tfa_btn_use_backup_code),
                style: TextStyle(color: AppTheme.loginTextColor),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  BackupCodeAuthRoute.name,
                  ModalRoute.withName(LoginRoute.name),
                  arguments: BackupCodeAuthRouteArgs(widget.args.isDialog,
                      widget.args.authBloc, widget.args.state),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
