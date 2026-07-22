class FidoAuthRequest {
  final String domainUrl;
  final double timeout;
  final String challenge;
  final String? requestId;
  final String rpId;
  final List<String> credentials;

  FidoAuthRequest(
    Duration requestTimeout,
    this.domainUrl,
    this.timeout,
    this.challenge,
    this.requestId,
    this.rpId,
    this.credentials,
  );

  bool get isNFC {
    throw 'Mock Not Implemented';
  }

  Future<Map<dynamic, dynamic>> start() {
    throw 'Mock Not Implemented';
  }

  void close() {
    throw 'Mock Not Implemented';
  }

  Future<bool> waitConnection(String message, String success) {
    throw 'Mock Not Implemented';
  }
}

class CanceledByUser {}

class FidoError {
  final String message;
  final FidoErrorCase errorCase;

  FidoError(this.message, this.errorCase);
}

enum FidoErrorCase {
  RequestFailed,
  EmptyResponse,
  Canceled,
  InvalidResult,
  ErrorResponse,
  MapError,
}
