import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/modules/auth/screens/component/two_factor_screen.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/auth/screens/select_two_factor/select_two_factor.dart';
import 'package:aurora_mail/modules/auth/screens/select_two_factor/select_two_factor_route.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/two_factor_auth/bloc.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/auth_input.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/login_gradient.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/mail_logo.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/presentation_header.dart';
import 'package:aurora_mail/modules/auth/screens/two_factor_auth/two_factor_auth_route.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:aurora_ui_kit/components/am_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/app_color.dart';
import 'package:theme/app_theme.dart';

class TwoFactorAuthWidget extends StatefulWidget {
  final TwoFactorAuthRouteArgs args;

  const TwoFactorAuthWidget({Key key, this.args}) : super(key: key);

  @override
  _TwoFactorAuthWidgetState createState() => _TwoFactorAuthWidgetState();
}

class _TwoFactorAuthWidgetState extends BState<TwoFactorAuthWidget> {
  final pinCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final bloc = TwoFactorBloc();

  @override
  Widget build(BuildContext context) {
    return TwoFactorScene(
      logoHint: "",
      isDialog: widget.args.isDialog,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            i18n(context, S.tfa_label),
            style: Theme.of(context).textTheme.title.copyWith(color: AppTheme.loginTextColor),
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
      button: ListView(
        padding: EdgeInsets.zero,
        children: [
          BlocListener<TwoFactorBloc, TwoFactorState>(
            bloc: bloc,
            listener: (BuildContext context, state) {
              if (state is ErrorState) {
                pinCtrl.clear();
                _showError(
                  context,
                  state.errorMsg,
                );
              } else if (state is CompleteState) {
                widget.args.authBloc.add(UserLogIn(state.user,null));
              }
            },
            child: BlocBuilder<TwoFactorBloc, TwoFactorState>(
                bloc: bloc,
                builder: (context, state) {
                  final loading = state is ProgressState || state is CompleteState;
                  return Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          i18n(context, S.tfa_input_hint_code_from_app),
                          style: TextStyle(color: AppTheme.loginTextColor),
                        ),
                        SizedBox(height: 20),
                        AuthInput(
                          controller: pinCtrl,
                          label: i18n(context, S.input_2fa_pin),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => validateInput(context, value, [ValidationType.empty]),
                          isEnabled: !loading,
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: AMButton(
                            shadow: AppColor.enableShadow ? null : BoxShadow(),
                            child: Text(
                              i18n(context, S.btn_verify_pin),
                              style: TextStyle(color: AppTheme.loginTextColor),
                            ),
                            isLoading: loading,
                            onPressed: () => _login(),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: FlatButton(
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
                                    widget.args.isDialog, widget.args.authBloc, widget.args.state),
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
      ),
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
