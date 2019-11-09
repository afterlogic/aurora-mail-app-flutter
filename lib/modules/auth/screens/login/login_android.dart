import 'dart:io';

import 'package:aurora_mail/modules/auth/blocs/auth/bloc.dart';
import 'package:aurora_mail/modules/auth/screens/login/components/auth_input.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/blocs/sync_settings/bloc.dart';
import 'package:aurora_mail/shared_ui/app_button.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginAndroid extends StatefulWidget {
  static final _authFormKey = GlobalKey<FormState>();

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
    if (!kReleaseMode) {
//    hostCtrl.text = "https://mail.privatemail.com";
      emailCtrl.text = "test@afterlogic.com";
      passwordCtrl.text = "p12345q";
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
    // TODO translate
    if (Platform.isIOS) {
      if (_showHostField && hostCtrl.text.isEmpty) {
        return _showError(context, "Please enter hostname");
      } else if (emailCtrl.text.isEmpty) {
        return _showError(context, "Please enter email");
      } else if (passwordCtrl.text.isEmpty) {
        return _showError(context, "Please enter password");
      }
    } else {
      final isValid = LoginAndroid._authFormKey.currentState.validate();
      if (!isValid) return;
    }

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
    return Scaffold(
      body: BlocListener(
          bloc: BlocProvider.of<AuthBloc>(context),
          listener: (context, state) {
            if (state is NeedsHost) {
              setState(() => _showHostField = true);
              // TODO translate
              showSnack(
                context: context,
                scaffoldState: Scaffold.of(context),
                duration: Duration(seconds: 6),
                msg:
                    "Could not detect domain from this email, please specify your server url manually.",
              );
            }
            if (state is LoggedIn) {
              if (state.user != null) {
                BlocProvider.of<SyncSettingsBloc>(context)
                    .add(InitSyncSettings(state.user));
              }
              Navigator.pushReplacementNamed(context, MessagesListRoute.name);
            }
            if (state is AuthError) {
              showSnack(
                  context: context,
                  scaffoldState: Scaffold.of(context),
                  msg: state.error);
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            bloc: BlocProvider.of<AuthBloc>(context),
            builder: (_, state) {
              if (state is LoggingIn) {
                return _buildLoginForm(loading: true);
              } else {
                return _buildLoginForm();
              }
            },
          )),
    );
  }

  Widget _buildLoginForm({bool loading = false}) {
    final mq = MediaQuery.of(context);

    return Container(
      child: SizedBox(
        height: mq.size.height - mq.viewInsets.bottom,
        width: mq.size.width,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            child: Form(
              key: LoginAndroid._authFormKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      // TODO translate
                      "Mail Client",
                      style: Theme.of(context).textTheme.display2,
                    ),
                  ),
                  SizedBox(height: 70.0),
                  if (_showHostField)
                    AuthInput(
                      controller: hostCtrl,
                      // TODO translate
                      label: "Host",
                      iconForIOS: MdiIcons.web,
                      keyboardType: TextInputType.url,
                      validator: (value) => _showHostField
                          ? validateInput(value, [ValidationType.empty])
                          : "",
                      isEnabled: !loading,
                    ),
                  SizedBox(height: 10),
                  AuthInput(
                    controller: emailCtrl,
                    // TODO translate
                    label: "Email",
                    iconForIOS: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => validateInput(
                        value, [ValidationType.empty, ValidationType.email]),
                    isEnabled: !loading,
                  ),
                  SizedBox(height: 10),
                  AuthInput(
                    controller: passwordCtrl,
                    // TODO translate
                    label: "Password",
                    iconForIOS: Icons.lock,
                    validator: (value) =>
                        validateInput(value, [ValidationType.empty]),
                    isPassword: true,
                    isEnabled: !loading,
                  ),
                  SizedBox(height: 40.0),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      // TODO translate
                      text: "Login",
                      buttonColor: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      isLoading: loading,
                      onPressed: () => _login(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//  List<Widget> _buildTextFields() {
//    if (Platform.isIOS) {
//      return [
//        if (_showHostField)
//          CupertinoTextField(
//            cursorColor: Theme.of(context).accentColor,
//            controller: hostCtrl,
//            keyboardType: TextInputType.url,
//            decoration: BoxDecoration(
//                border: Border(bottom: BorderSide(color: Colors.white38))),
//            placeholder: "Host",
//            autocorrect: false,
//            prefix: Opacity(
//              opacity: 0.6,
//              child: Padding(
//                padding: const EdgeInsets.fromLTRB(0.0, 12.0, 8.0, 12.0),
//                child: Icon(MdiIcons.web),
//              ),
//            ),
//          ),
//        SizedBox(height: 20),
//        CupertinoTextField(
//          cursorColor: Theme.of(context).accentColor,
//          controller: emailCtrl,
//          keyboardType: TextInputType.emailAddress,
//          decoration: BoxDecoration(
//              border: Border(bottom: BorderSide(color: Colors.white38))),
//          placeholder: "Email",
//          autocorrect: false,
//          prefix: Opacity(
//            opacity: 0.6,
//            child: Padding(
//              padding: const EdgeInsets.fromLTRB(0.0, 12.0, 8.0, 12.0),
//              child: Icon(Icons.email),
//            ),
//          ),
//        ),
//        SizedBox(height: 20),
//        CupertinoTextField(
//          cursorColor: Theme.of(context).accentColor,
//          controller: passwordCtrl,
//          decoration: BoxDecoration(
//              border: Border(bottom: BorderSide(color: Colors.white38))),
//          placeholder: "Password",
//          obscureText: _obscureText,
//          autocorrect: false,
//          prefix: Opacity(
//            opacity: 0.6,
//            child: Padding(
//              padding: const EdgeInsets.fromLTRB(0.0, 12.0, 8.0, 12.0),
//              child: Icon(
//                Icons.lock,
//              ),
//            ),
//          ),
//          suffix: IconButton(
//            icon: Icon(
//              _obscureText ? Icons.visibility : Icons.visibility_off,
//              color: Colors.white70,
//            ),
//            onPressed: () => setState(() => _obscureText = !_obscureText),
//          ),
//        ),
//      ];
//    } else {
//      return [
//        if (_showHostField)
//          TextFormField(
//            cursorColor: Theme.of(context).accentColor,
//            controller: hostCtrl,
//            keyboardType: TextInputType.url,
//            validator: (value) => _showHostField
//                ? validateInput(value, [ValidationTypes.empty])
//                : "",
//            decoration: InputDecoration(
//              alignLabelWithHint: true,
//              labelText: "Host",
//            ),
//          ),
//        SizedBox(height: 10),
//        TextFormField(
//          cursorColor: Theme.of(context).accentColor,
//          controller: emailCtrl,
//          keyboardType: TextInputType.emailAddress,
//          validator: (value) => validateInput(
//              value, [ValidationTypes.empty, ValidationTypes.email]),
//          decoration: InputDecoration(
//            labelText: "Email",
//            alignLabelWithHint: true,
//          ),
//        ),
//        SizedBox(height: 10),
//        TextFormField(
//          cursorColor: Theme.of(context).accentColor,
//          controller: passwordCtrl,
//          validator: (value) => validateInput(value, [ValidationTypes.empty]),
//          obscureText: _obscureText,
//          decoration: InputDecoration(
//            labelText: "Password",
//            alignLabelWithHint: true,
//            suffixIcon: GestureDetector(
//              child: Padding(
//                padding: const EdgeInsets.only(top: 16.0),
//                child: Icon(
//                  _obscureText ? Icons.visibility : Icons.visibility_off,
//                  color: Colors.white70,
//                ),
//              ),
//              onTap: () => setState(() => _obscureText = !_obscureText),
//            ),
//          ),
//        ),
//      ];
//    }
//  }
