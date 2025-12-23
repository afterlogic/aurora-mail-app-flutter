class TwoFactorAuthModel {
  final bool hasAuthenticatorApp;
  final bool hasSecurityKey;
  final bool hasBackupCodes;
  final bool mandatoryToConfigure;

  const TwoFactorAuthModel({
    this.hasAuthenticatorApp = false,
    this.hasSecurityKey = false,
    this.hasBackupCodes = false,
    this.mandatoryToConfigure = false,
  });

  factory TwoFactorAuthModel.fromJson(Map<String, dynamic> json) {
    return TwoFactorAuthModel(
      hasAuthenticatorApp: json['HasAuthenticatorApp'] as bool? ?? false,
      hasSecurityKey: json['HasSecurityKey'] as bool? ?? false,
      hasBackupCodes: json['HasBackupCodes'] as bool? ?? false,
      mandatoryToConfigure: json['MandatoryToConfigure'] as bool? ?? false,
    );
  }

  factory TwoFactorAuthModel.debug() {
    return TwoFactorAuthModel(
      hasAuthenticatorApp: true,
      hasSecurityKey: true,
      hasBackupCodes: true,
      mandatoryToConfigure: true,
    );
  }
}

class RequestTwoFactorError extends Error {
  final String host;
  final TwoFactorAuthModel twoFactorModel;

  RequestTwoFactorError({
    required this.host,
    required this.twoFactorModel,
  });
}

class AllowAccessError extends Error {}

class InvalidPinError extends Error {}

class AppCheckValidationError extends Error {}

class SecurityKeyBegin {
  final String host;
  final double timeout;
  final String challenge;
  final String rpId;
  final List<String> allowCredentials;

  SecurityKeyBegin(
    this.host,
    this.timeout,
    this.challenge,
    this.rpId,
    this.allowCredentials,
  );
}
