import 'dart:async';

import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/ios_fido_auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/ios_fido_auth_bloc/event.dart';
import 'package:aurora_mail/modules/auth/blocs/ios_fido_auth_bloc/state.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/components/dialogs/am_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yubico_flutter/yubico_flutter.dart';

class IosFidoAuth extends StatefulWidget {
  final String host;
  final String login;
  final String password;
  final AuthBloc authBloc;

  const IosFidoAuth(
    this.host,
    this.login,
    this.password,
    this.authBloc,
  );

  @override
  _IosFidoAuthState createState() => _IosFidoAuthState();
}

class _IosFidoAuthState extends BState<IosFidoAuth> {
  IosFidoAuthBloc bloc;
  StreamSubscription sub;
  bool waitConnect = false;

  @override
  void initState() {
    super.initState();
    bloc = IosFidoAuthBloc(
      widget.host,
      widget.login,
      widget.password,
      widget.authBloc,
    );
  }

  @override
  dispose() {
    bloc.close();
    super.dispose();
    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AMDialog(
      title: Text("Fido auth"),
      content: BlocListener<IosFidoAuthBloc, IosFidoAuthState>(
        bloc: bloc,
        listener: (BuildContext context, state) {},
        child: BlocBuilder<IosFidoAuthBloc, IosFidoAuthState>(
          bloc: bloc,
          builder: (BuildContext context, state) {
            if (state is ErrorState) {
              return Column(
                children: [
                  Text(
                    state.errorToShow.getString(context),
                    style: TextStyle(color: Colors.red),
                  ),
                  Row(
                    children: [
                      FlatButton(
                          onPressed: () => bloc.add(StartAuth(true)),
                          child: Text("NFC")),
                      FlatButton(
                          onPressed: () => bloc.add(StartAuth(false)),
                          child: Text("MFI"))
                    ],
                  ),
                ],
              );
            }
            if (state is SendingBeginAuthRequestState) {
              return Center(
                child: Text("SendingBeginAuthRequestState"),
              );
            }
            if (state is WaitKeyState) {
              return Center(
                child: Text("WaitKeyState"),
              );
            }
            if (state is TouchKeyState) {
              return Center(
                child: Text("TouchKeyState"),
              );
            }
            if (state is SendingFinishAuthRequestState) {
              return Center(
                child: Text("SendingFinishAuthRequestState"),
              );
            }

            return Row(
              children: [
                FlatButton(
                    onPressed: () => bloc.add(StartAuth(true)),
                    child: Text("NFC")),
                FlatButton(
                    onPressed: () => bloc.add(StartAuth(false)),
                    child: Text("MFI"))
              ],
            );
          },
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(i18n(context, S.btn_cancel)))
      ],
    );
  }
}
