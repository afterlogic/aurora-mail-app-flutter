//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/blocs/fido_auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/fido_auth_bloc/event.dart';
import 'package:aurora_mail/modules/auth/blocs/fido_auth_bloc/state.dart';
import 'package:aurora_mail/modules/auth/screens/component/two_factor_screen.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/auth/screens/select_two_factor/select_two_factor_route.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/app_color.dart';
import 'package:theme/app_theme.dart';

import 'nfc_dialog.dart';
import 'fido_auth_route.dart';

class IosFidoAuthWidget extends StatefulWidget {
  final FidoAuthRouteArgs args;

  const IosFidoAuthWidget({Key key, this.args}) : super(key: key);

  @override
  _IosFidoAuthWidgetState createState() => _IosFidoAuthWidgetState();
}

class _IosFidoAuthWidgetState extends BState<IosFidoAuthWidget> {
  FidoAuthBloc bloc;
  final touchDialogKey = GlobalKey<IosPressOnKeyDialogState>();

  @override
  void initState() {
    super.initState();
    bloc = FidoAuthBloc(
      widget.args.state.hostname,
      widget.args.state.email,
      widget.args.state.password,
      widget.args.authBloc,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(StartAuth(true, S.of(context).fido_label_connect_your_key,
          S.of(context).fido_label_success));
    });
  }

  @override
  dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TwoFactorScene(
      logoHint: "",
      isDialog: widget.args.isDialog,
      button: [
        BlocListener<FidoAuthBloc, FidoAuthState>(
          bloc: bloc,
          listener: (BuildContext context, state) {
            if (state is ErrorState) {
              if (state.errorToShow != null) {
                _showError(context, state.errorToShow);
              }
            }
            if (state is TouchKeyState) {
              if (touchDialogKey.currentState != null) {
                touchDialogKey.currentState.close();
              }
              IosPressOnKeyDialog(touchDialogKey, () => bloc.add(Cancel()))
                  .show(context);
            } else if (state is SendingFinishAuthRequestState) {
              if (touchDialogKey.currentState != null) {
                touchDialogKey.currentState
                    .success()
                    .then((value) => state.waitSheet?.complete());
              } else {
                state.waitSheet?.complete();
              }
            } else {
              if (touchDialogKey.currentState != null) {
                touchDialogKey.currentState.close();
              }
            }
          },
          child: BlocBuilder<FidoAuthBloc, FidoAuthState>(
            bloc: bloc,
            builder: (_, state) {
              return state is InitState || state is ErrorState
                  ? Column(
                      children: [
                        Text(
                          S.of(context).fido_error_title,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline6
                              .copyWith(color: AppTheme.loginTextColor),
                        ),
                        SizedBox(height: 10),
                        Text(
                          S.of(context).fido_error_hint,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppTheme.loginTextColor),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: AMButton(
                            color: Theme.of(context).primaryColor,
                            shadow: AppColor.enableShadow ? null : BoxShadow(),
                            child: Text(
                              S.of(context).fido_btn_try_again,
                              style: TextStyle(color: AppTheme.loginTextColor),
                            ),
                            onPressed: () {
                              bloc.add(StartAuth(
                                  true,
                                  S.of(context).fido_label_connect_your_key,
                                  S.of(context).fido_label_success));
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            child: Text(
                              S.of(context).tfa_btn_other_options,
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
                    )
                  : (state is WaitWebView
                      ? Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              TextButton(
                                onPressed: () {
                                  bloc.add(Cancel());
                                },
                                child: Text(S.of(context).btn_cancel),
                              )
                            ],
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ));
            },
          ),
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
}
