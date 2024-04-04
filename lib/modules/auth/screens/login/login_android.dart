//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/screens/fido_auth/fido_auth_route.dart';
import 'package:aurora_mail/modules/auth/screens/trust_device/trust_device_route.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/auth_input.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/host_input_formatter.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/login_gradient.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/presentation_header.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/auth/screens/two_factor_auth/two_factor_auth_route.dart';
import 'package:aurora_mail/modules/auth/screens/upgrade_plan/upgrade_plan_route.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/shared_ui/restart_widget.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/app_color.dart';
import 'package:theme/app_theme.dart';

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

class _LoginAndroidState extends BState<LoginAndroid> {
  final hostCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool _showHostField = false;

  @override
  void initState() {
    super.initState();

    if (widget.isDialog == true) {
      if (widget.email != null) emailCtrl.text = widget.email;
    } else {
      BlocProvider.of<AuthBloc>(context).add(GetLastEmail());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isTablet = LayoutConfig.of(context).isTablet;
    if (!isTablet) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
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

  void _showError(BuildContext context, ErrorToShow errorToShow) {
    showErrorSnack(
      context: context,
      scaffoldState: Scaffold.of(context),
      msg: errorToShow,
    );
  }

  void _login(BuildContext context) {
    final isValid = LoginAndroid._authFormKey.currentState.validate();
    if (!isValid) return;

    // else
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    BlocProvider.of<AuthBloc>(context).add(LogIn(
      email: emailCtrl.text,
      password: passwordCtrl.text.trim(),
      hostname: hostCtrl.text,
      firstLogin: !widget.isDialog,
    ));
  }

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
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: (widget.isDialog && !LayoutConfig.of(context).isTablet)
          ? AMAppBar(
              title: Text(
                widget.email == null
                    ? S.of(context).settings_accounts_add
                    : S.of(context).settings_accounts_relogin,
              ),
            )
          : null,
      body: _gradientWrap(
        BlocListener(
            bloc: authBloc,
            listener: (context, state) {
              if (state is ShowTrustDeviceDialog) {
                Navigator.pushNamed(
                  context,
                  TrustDeviceRoute.name,
                  arguments: TrustDeviceRouteArgs(
                    widget.isDialog,
                    authBloc,
                    state.user,
                    state.email,
                    state.password,
                    state.daysCount,
                  ),
                );
              }
              if (state is TwoFactor) {
                if (state.hasSecurityKey == true && BuildProperty.useYubiKit) {
                  Navigator.pushNamed(
                    context,
                    FidoAuthRoute.name,
                    arguments: FidoAuthRouteArgs(
                      widget.isDialog,
                      authBloc,
                      state,
                    ),
                  );
                } else if (state.hasAuthenticatorApp == true) {
                  Navigator.pushNamed(
                    context,
                    TwoFactorAuthRoute.name,
                    arguments: TwoFactorAuthRouteArgs(
                      widget.isDialog,
                      authBloc,
                      state,
                    ),
                  );
                }
                return;
              }
              if (state is ReceivedLastEmail) {
                emailCtrl.text = state.email;
              }
              if (state is NeedsHost) {
                setState(() => _showHostField = true);
                _showError(
                  context,
                  ErrorToShow.message(S.of(context).error_login_auto_discover),
                );
              }
              if (state is InitializedUserAndAccounts) {
                if (state.user != null) {
                  BlocProvider.of<SettingsBloc>(context)
                      .add(InitSettings(state.user, state.users));
                }

                if (widget.isDialog) {
                  RestartWidget.restartApp(context);
                } else {
                  Navigator.popUntil(
                      context, ModalRoute.withName(LoginRoute.name));
                  Navigator.pushReplacementNamed(
                      context, MessagesListRoute.name);
                }
              }
              if (state is AlreadyLoggedError) {
                showErrorSnack(
                  context: context,
                  scaffoldState: Scaffold.of(context),
                  msg: ErrorToShow.message(
                      S.of(context).error_user_already_logged),
                );
              }
              if (state is UpgradePlan) {
                if (widget.isDialog) {
                  showErrorSnack(
                    context: context,
                    scaffoldState: Scaffold.of(context),
                    msg: state.err,
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    UpgradePlanRoute.name,
                    arguments: UpgradePlanArg(null),
                  );
                }
              }
              if (state is AuthError) {
                _showError(
                  context,
                  ErrorToShow.message(state.errorMsg.message),
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
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, {bool loading = false}) {
    return Stack(
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
                        if (widget.isDialog &&
                            LayoutConfig.of(context).isTablet)
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              widget.email == null
                                  ? S.of(context).settings_accounts_add
                                  : S.of(context).settings_accounts_relogin,
                              style: theme.textTheme.headline6,
                            ),
                          ),
                        if (_showHostField)
                          AuthInput(
                            controller: hostCtrl,
                            inputFormatters: [HostInputFormatter()],
                            label: S.of(context).login_input_host,
                            keyboardType: TextInputType.url,
                            isEnabled: !loading,
                          ),
                        SizedBox(height: 10),
                        AuthInput(
                          enableSuggestions: false,
                          autocorrect: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(" ")
                          ],
                          controller: emailCtrl,
                          label: S.of(context).login_input_email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => validateInput(context, value,
                              [ValidationType.empty, ValidationType.email]),
                          isEnabled: !loading,
                        ),
                        SizedBox(height: 10),
                        AuthInput(
                          controller: passwordCtrl,
                          label: S.of(context).login_input_password,
                          validator: (value) => validateInput(
                              context, value, [ValidationType.empty]),
                          isPassword: true,
                          isEnabled: !loading,
                        ),
                      ],
                    ),
                    if (widget.isDialog) SizedBox(height: 40.0),
                    SizedBox(
                      width: double.infinity,
                      child: _debugRouteToTwoFactor(
                        AMButton(
                          color: Theme.of(context).primaryColor,
                          shadow: AppColor.enableShadow ? null : BoxShadow(),
                          child: Text(
                              widget.isDialog
                                  ? S.of(context).btn_add_account
                                  : S.of(context).btn_login,
                              style: TextStyle(color: Colors.white)),
                          isLoading: loading,
                          onPressed: () => _login(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _debugRouteToTwoFactor(Widget child) {
    if (kDebugMode) {
      return GestureDetector(
        onLongPress: () => Navigator.pushNamed(
          context,
          UpgradePlanRoute.name,
        ),
        onDoubleTap: () => Navigator.pushNamed(
          context,
          TwoFactorAuthRoute.name,
          arguments: TwoFactorAuthRouteArgs(
              widget.isDialog,
              BlocProvider.of<AuthBloc>(context),
              TwoFactor(
                "",
                "",
                "",
                true,
                true,
                true,
              )),
        ),
        child: child,
      );
    } else {
      return child;
    }
  }
}
