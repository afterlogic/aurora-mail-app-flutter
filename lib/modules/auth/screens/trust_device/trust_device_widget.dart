import 'package:aurora_mail/modules/auth/blocs/trust_device/trust_device_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/trust_device/trust_device_event.dart';
import 'package:aurora_mail/modules/auth/blocs/trust_device/trust_device_state.dart';
import 'package:aurora_mail/modules/auth/screens/component/two_factor_screen.dart';
import 'package:aurora_mail/modules/auth/screens/login/login_route.dart';
import 'package:aurora_mail/modules/auth/screens/select_two_factor/select_two_factor_route.dart';
import 'package:aurora_mail/modules/auth/screens/trust_device/trust_device_route.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:aurora_ui_kit/components/am_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/app_color.dart';
import 'package:theme/app_theme.dart';

class TrustDeviceWidget extends StatefulWidget {
  final TrustDeviceRouteArgs args;

  const TrustDeviceWidget({Key key, this.args}) : super(key: key);

  @override
  _TrustDeviceWidgetState createState() => _TrustDeviceWidgetState();
}

class _TrustDeviceWidgetState extends BState<TrustDeviceWidget> {
  TrustDeviceBloc bloc;
  bool check = false;

  @override
  void initState() {
    super.initState();
    bloc = TrustDeviceBloc(
      widget.args.login,
      widget.args.password,
      widget.args.user,
      widget.args.authBloc,
    );
  }

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
      allowBack: false,
      button: [
        BlocListener<TrustDeviceBloc, TrustDeviceState>(
          bloc: bloc,
          listener: (BuildContext context, state) {
            if (state is ErrorState) {
              _showError(context, state.errorMsg);
            }
          },
          child: BlocBuilder<TrustDeviceBloc, TrustDeviceState>(
              bloc: bloc,
              builder: (context, state) {
                final loading =
                    state is ProgressState || state is CompleteState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      i18n(context, S.tfa_label_trust_device),
                      style: TextStyle(color: AppTheme.loginTextColor),
                    ),
                    SizedBox(height: 20),
                    IgnorePointer(
                      ignoring: loading,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: check,
                        onChanged: (value) {
                          check = value;
                          setState(() {});
                        },
                        title: Text(
                          i18n(context, S.tfa_check_box_trust_device,
                              {"daysCount": widget.args.daysCount.toString()}),
                          style: TextStyle(color: AppTheme.loginTextColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: AMButton(
                        shadow: AppColor.enableShadow ? null : BoxShadow(),
                        child: Text(
                          i18n(context, S.tfa_button_continue),
                          style: TextStyle(color: AppTheme.loginTextColor),
                        ),
                        isLoading: loading,
                        onPressed: () {
                          bloc.add(TrustThisDevice(check));
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
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
}
