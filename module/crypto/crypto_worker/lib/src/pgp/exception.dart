abstract class PgpException extends Error {}

class PgpKeyNotFound extends PgpException {
  final List<String> email;

  PgpKeyNotFound(this.email);

  @override
  String toString() {
    return "not found pgp key for $email";
  }
}

class PgpInvalidSign extends PgpException {
  @override
  String toString() {
    return "invalid password";
  }
}

class PgpDecryptError extends PgpException {
  @override
  String toString() {
    return "cant decrypt";
  }
}
