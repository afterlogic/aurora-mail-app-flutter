class ServerError implements Exception {
  final String message;

  ServerError(this.message) : super();

  @override
  String toString() => message;
}