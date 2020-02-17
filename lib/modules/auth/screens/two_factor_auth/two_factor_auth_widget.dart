import 'package:aurora_mail/modules/auth/blocs/two_factor_auth/bloc.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/auth_input.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/mail_logo.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/presentation_header.dart';
import 'package:aurora_mail/modules/auth/screens/two_factor_auth/two_factor_auth_route.dart';
import 'package:aurora_ui_kit/components/am_button.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TwoFactorAuthWidget extends StatefulWidget {
  final TwoFactorAuthRouteArgs args;

  const TwoFactorAuthWidget({Key key, this.args}) : super(key: key);

  @override
  _TwoFactorAuthWidgetState createState() => _TwoFactorAuthWidgetState();
}

class _TwoFactorAuthWidgetState extends State<TwoFactorAuthWidget> {
  final pinCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final bloc = TwoFactorBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<TwoFactorBloc, TwoFactorState>(
        bloc: bloc,
        listener: (BuildContext context, state) {
          if (state is ErrorState) {
            _showError(
              context,
              i18n(context, state.errorMsg),
            );
          } else if (state is CompleteState) {
            Navigator.pop(context, state.user);
          }
        },
        child: BlocBuilder<TwoFactorBloc, TwoFactorState>(
          bloc: bloc,
          builder: (_, state) => _buildPinForm(context, state),
        ),
      ),
    );
  }

  Widget _buildPinForm(BuildContext context, TwoFactorState state) {
    final loading = state is ProgressState;

    return Stack(
      children: <Widget>[
        if (!widget.args.isDialog)
          Positioned(
            top: -70.0,
            left: -70.0,
            child: MailLogo(isBackground: true),
          ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 22.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: widget.args.isDialog
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (!widget.args.isDialog)
                  PresentationHeader(
                    message: i18n(context, "two_factor_auth"),
                  ),
                Column(
                  children: <Widget>[
                    AuthInput(
                      controller: pinCtrl,
                      label: i18n(context, "pin"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          validateInput(context, value, [ValidationType.empty]),
                      isEnabled: !loading,
                    ),
                  ],
                ),
                if (widget.args.isDialog) SizedBox(height: 40.0),
                SizedBox(
                  width: double.infinity,
                  child: AMButton(
                    child: Text(i18n(context, "verify_pin")),
                    isLoading: loading,
                    onPressed: () => _login(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showError(BuildContext context, String msg) {
    showSnack(
      context: context,
      scaffoldState: Scaffold.of(context),
      msg: msg,
    );
  }

  _login() {
    if (formKey.currentState.validate()) {
      final args = widget.args;
      bloc.add(LogIn(
        pinCtrl.text,
        args.host,
        args.login,
        args.password,
      ));
    }
  }
}