class TwoFactorAuthRoute {
  static const name = "twoFactorAuthRoute";
}

class TwoFactorAuthRouteArgs {
  final bool isDialog;
  final String host;
  final String login;
  final String password;

  const TwoFactorAuthRouteArgs(
    this.host,
    this.login,
    this.password,
    this.isDialog,
  );
}
