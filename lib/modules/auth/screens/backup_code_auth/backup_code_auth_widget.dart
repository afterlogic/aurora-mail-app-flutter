//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/blocs/backup_code_auth/backup_code_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/backup_code_auth/backup_code_event.dart';
import 'package:aurora_mail/modules/auth/blocs/backup_code_auth/backup_code_state.dart';
import 'package:aurora_mail/modules/auth/screens/component/two_factor_screen.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/auth/screens/select_two_factor/select_two_factor_route.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/auth_input.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:aurora_ui_kit/components/am_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/app_color.dart';
import 'package:theme/app_theme.dart';

import 'backup_code_auth_route.dart';

class BackupCodeAuthWidget extends StatefulWidget {
  final BackupCodeAuthRouteArgs args;

  const BackupCodeAuthWidget({Key key, this.args}) : super(key: key);

  @override
  _BackupCodeAuthWidgetState createState() => _BackupCodeAuthWidgetState();
}

class _BackupCodeAuthWidgetState extends BState<BackupCodeAuthWidget> {
  final pinCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final bloc = BackupCodeBloc();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return TwoFactorScene(
      logoHint: "",
      isDialog: widget.args.isDialog,
      button: [
        BlocListener<BackupCodeBloc, BackupCodeState>(
          bloc: bloc,
          listener: (BuildContext context, state) {
            if (state is ErrorState) {
              pinCtrl.clear();
              _showError(
                context,
                state.errorMsg,
              );
            } else if (state is CompleteState) {
              widget.args.authBloc.add(UserLogIn(
                state.user,
                null,
                widget.args.state.email,
                widget.args.state.password,
              ));
            }
          },
          child: BlocBuilder<BackupCodeBloc, BackupCodeState>(
              bloc: bloc,
              builder: (context, state) {
                final loading =
                    state is ProgressState || state is CompleteState;
                return Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).tfa_label_enter_backup_code,
                        style: TextStyle(color: AppTheme.loginTextColor),
                      ),
                      SizedBox(height: 20),
                      AuthInput(
                        controller: pinCtrl,
                        label: S.of(context).tfa_input_backup_code,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => validateInput(
                            context, value, [ValidationType.empty]),
                        isEnabled: !loading,
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: AMButton(
                          color: Theme.of(context).primaryColor,
                          shadow: AppColor.enableShadow ? null : BoxShadow(),
                          child: Text(
                            S.of(context).btn_verify_pin,
                            style: TextStyle(color: AppTheme.loginTextColor),
                          ),
                          isLoading: loading,
                          onPressed: () => _login(),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          child: Text(
                            "Other options",
                            style: TextStyle(color: AppTheme.loginTextColor),
                          ),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              SelectTwoFactorRoute.name,
                              ModalRoute.withName(LoginRoute.name),
                              arguments: SelectTwoFactorRouteArgs(
                                  widget.args.isDialog,
                                  widget.args.authBloc,
                                  widget.args.state),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }

  void _showError(BuildContext context, ErrorToShow msg) {
    showErrorSnack(
      context: context,
      scaffoldState: Scaffold.of(context),
      msg: msg,
    );
  }

  _login() {
    if (formKey.currentState.validate()) {
      final args = widget.args;
      bloc.add(
        Verify(
          pinCtrl.text,
          args.state.hostname,
          args.state.email,
          args.state.password,
        ),
      );
    }
  }
}
