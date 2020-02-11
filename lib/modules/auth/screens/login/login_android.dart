import 'dart:io';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/auth_input.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/presentation_header.dart';
import 'package:aurora_mail/modules/auth/screens/two_factor_auth/two_factor_auth_route.dart';
import 'package:aurora_mail/modules/auth/screens/two_factor_auth/two_factor_auth_widget.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/shared_ui/app_button.dart';
import 'package:aurora_mail/shared_ui/restart_widget.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_mail/build_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'auth_data.dart';
import 'components/mail_logo.dart';

class LoginAndroid extends StatefulWidget {
  static final _authFormKey = GlobalKey<FormState>();

  final bool isDialog;
  final String email;

  const LoginAndroid({Key key, this.isDialog = false, this.email})
      : super(key: key);

  @override
  _LoginAndroidState createState() => _LoginAndroidState();
}

class _LoginAndroidState extends State<LoginAndroid> {
  final hostCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool _showHostField = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (kDebugMode && !widget.isDialog) {
      emailCtrl.text = AuthData.email;
      passwordCtrl.text = AuthData.password;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.isDialog == true) {
      if (widget.email != null) emailCtrl.text = widget.email;
    } else {
      BlocProvider.of<AuthBloc>(context).add(GetLastEmail());
    }
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _showError(BuildContext context, String msg) {
    showSnack(
      context: context,
      scaffoldState: Scaffold.of(context),
      msg: msg,
    );
  }

  void _login(BuildContext context) {
    final isValid = LoginAndroid._authFormKey.currentState.validate();
    if (!isValid) return;

    // else
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    BlocProvider.of<AuthBloc>(context).add(LogIn(
      email: emailCtrl.text,
      password: passwordCtrl.text,
      hostname: hostCtrl.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: widget.isDialog
          ? AppBar(
              centerTitle: true,
              title: Text(i18n(
                  context,
                  widget.email == null
                      ? "settings_accounts_add"
                      : "settings_accounts_relogin")),
            )
          : null,
      body: BlocListener(
          bloc: authBloc,
          listener: (context, state) {
            if (state is TwoFactor) {
              Navigator.pushNamed(
                context,
                TwoFactorAuthRoute.name,
                arguments: TwoFactorAuthRouteArgs(state.hostname, state.email,
                    state.password, widget.isDialog),
              ).then((value) {
                if (value is User) {
                  authBloc.add(UserLogIn(value));
                }
              });
              return;
            }

            if (state is ReceivedLastEmail) {
              emailCtrl.text = state.email;
            }

            if (state is NeedsHost) {
              setState(() => _showHostField = true);
              _showError(
                context,
                i18n(context, "error_login_auto_discover"),
              );
            }
            if (state is LoggedIn) {
              if (state.user != null) {
                BlocProvider.of<SettingsBloc>(context)
                    .add(InitSettings(state.user, state.users));
              }

              if (widget.isDialog) {
                RestartWidget.restartApp(context);
              } else {
                Navigator.pushReplacementNamed(context, MessagesListRoute.name);
              }
            }
            if (state is AuthError) {
              showSnack(
                context: context,
                scaffoldState: Scaffold.of(context),
                msg: state.errorMsg,
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            bloc: BlocProvider.of<AuthBloc>(context),
            builder: (context, state) {
              if (state is LoggingIn) {
                return _buildLoginForm(context, loading: true);
              } else {
                return _buildLoginForm(context);
              }
            },
          )),
    );
  }

  Widget _buildLoginForm(BuildContext context, {bool loading = false}) {
    return Stack(
      children: <Widget>[
        if (!widget.isDialog)
          Positioned(
            top: -70.0,
            left: -70.0,
            child: MailLogo(isBackground: true),
          ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 22.0),
          child: Form(
            key: LoginAndroid._authFormKey,
            child: Column(
              mainAxisAlignment: widget.isDialog
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (!widget.isDialog) PresentationHeader(),
                Column(
                  children: <Widget>[
                    if (_showHostField)
                      AuthInput(
                        controller: hostCtrl,
                        label: i18n(context, "login_input_host"),
                        keyboardType: TextInputType.url,
                        isEnabled: !loading,
                      ),
                    SizedBox(height: 10),
                    AuthInput(
                      controller: emailCtrl,
                      label: i18n(context, "login_input_email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => validateInput(context, value,
                          [ValidationType.empty, ValidationType.email]),
                      isEnabled: !loading,
                    ),
                    SizedBox(height: 10),
                    AuthInput(
                      controller: passwordCtrl,
                      label: i18n(context, "login_input_password"),
                      validator: (value) =>
                          validateInput(context, value, [ValidationType.empty]),
                      isPassword: true,
                      isEnabled: !loading,
                    ),
                  ],
                ),
                if (widget.isDialog) SizedBox(height: 40.0),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    text: i18n(context,
                        widget.isDialog ? "btn_add_account" : "btn_login"),
                    isLoading: loading,
                    onPressed: () => _login(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
