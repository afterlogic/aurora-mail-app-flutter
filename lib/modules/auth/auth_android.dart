import 'dart:io';

import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/auth/state/auth_state.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/shared_ui/app_button.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class AuthAndroid extends StatefulWidget {
  static final _authFormKey = GlobalKey<FormState>();

  @override
  _AuthAndroidState createState() => _AuthAndroidState();
}

class _AuthAndroidState extends State<AuthAndroid> {
  AuthState _authState = AppStore.authState;
  bool _showHostField = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _authState.isLoggingIn = false;
    _authState.emailCtrl.text = _authState.userEmail;
    _authState.passwordCtrl.text = "";
//    _authState.hostCtrl.text = "https://mail.privatemail.com";
    _authState.emailCtrl.text = "test@afterlogic.com";
    _authState.passwordCtrl.text = "p12345q";
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

  Future _login(BuildContext context) async {
    String errMsg = "";
    if (Platform.isIOS) {
      if (_showHostField && _authState.hostCtrl.text.isEmpty) {
        errMsg = "Please enter hostname";
      } else if (_authState.emailCtrl.text.isEmpty) {
        errMsg = "Please enter email";
      } else if (_authState.passwordCtrl.text.isEmpty) {
        errMsg = "Please enter password";
      }
    }
    if (errMsg.isEmpty) {
      final showHost = await _authState.onLogin(
        isFormValid: AuthAndroid._authFormKey.currentState.validate(),
        onSuccess: () async {
          Navigator.pushReplacementNamed(context, MessagesListRoute.name);
        },
        onError: (String err) => showSnack(
          context: context,
          scaffoldState: Scaffold.of(context),
          msg: err,
        ),
      );
      if (showHost) {
        _authState.hostCtrl.text = _authState.hostName;
        setState(() => _showHostField = true);
        showSnack(
          context: context,
          scaffoldState: Scaffold.of(context),
          duration: Duration(seconds: 6),
          msg:
              "Could not detect domain from this email, please specify your server url manually.",
        );
      }
    } else {
      showSnack(
        context: context,
        scaffoldState: Scaffold.of(context),
        msg: errMsg,
      );
    }
  }

  List<Widget> _buildTextFields() {
    if (Platform.isIOS) {
      return [
        if (_showHostField)
          CupertinoTextField(
            cursorColor: Theme.of(context).accentColor,
            controller: _authState.hostCtrl,
            keyboardType: TextInputType.url,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white38))),
            placeholder: "Host",
            autocorrect: false,
            prefix: Opacity(
              opacity: 0.6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 12.0, 8.0, 12.0),
                child: Icon(MdiIcons.web),
              ),
            ),
          ),
        SizedBox(height: 20),
        CupertinoTextField(
          cursorColor: Theme.of(context).accentColor,
          controller: _authState.emailCtrl,
          keyboardType: TextInputType.emailAddress,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white38))),
          placeholder: "Email",
          autocorrect: false,
          prefix: Opacity(
            opacity: 0.6,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 12.0, 8.0, 12.0),
              child: Icon(Icons.email),
            ),
          ),
        ),
        SizedBox(height: 20),
        CupertinoTextField(
          cursorColor: Theme.of(context).accentColor,
          controller: _authState.passwordCtrl,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white38))),
          placeholder: "Password",
          obscureText: _obscureText,
          autocorrect: false,
          prefix: Opacity(
            opacity: 0.6,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 12.0, 8.0, 12.0),
              child: Icon(
                Icons.lock,
              ),
            ),
          ),
          suffix: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.white70,
            ),
            onPressed: () => setState(() => _obscureText = !_obscureText),
          ),
        ),
      ];
    } else {
      return [
        if (_showHostField)
          TextFormField(
            cursorColor: Theme.of(context).accentColor,
            controller: _authState.hostCtrl,
            keyboardType: TextInputType.url,
            validator: (value) => _showHostField
                ? validateInput(value, [ValidationTypes.empty])
                : "",
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: "Host",
            ),
          ),
        SizedBox(height: 10),
        TextFormField(
          cursorColor: Theme.of(context).accentColor,
          controller: _authState.emailCtrl,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => validateInput(
              value, [ValidationTypes.empty, ValidationTypes.email]),
          decoration: InputDecoration(
            labelText: "Email",
            alignLabelWithHint: true,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          cursorColor: Theme.of(context).accentColor,
          controller: _authState.passwordCtrl,
          validator: (value) => validateInput(value, [ValidationTypes.empty]),
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelText: "Password",
            alignLabelWithHint: true,
            suffixIcon: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white70,
                ),
              ),
              onTap: () => setState(() => _obscureText = !_obscureText),
            ),
          ),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Provider(
      builder: (_) => _authState,
      child: Scaffold(
        body: Container(
          child: SizedBox(
            height: mq.size.height - mq.viewInsets.bottom,
            width: mq.size.width,
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                child: Form(
                  key: AuthAndroid._authFormKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text("Mail Client", style: Theme.of(context).textTheme.display2,),
                      ),
                      SizedBox(height: 70.0),
                      ..._buildTextFields(),
                      SizedBox(height: 40.0),
                      SizedBox(
                        width: double.infinity,
                        child: Observer(
                          builder: (BuildContext context) => AppButton(
                            text: "Login",
                            buttonColor: Theme.of(context).accentColor,
                            textColor: Colors.white,
                            isLoading: _authState.isLoggingIn,
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
        ),
      ),
    );
  }
}
