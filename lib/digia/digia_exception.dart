class DigiaException implements Exception {
  final String message;
  DigiaException(this.message);

  @override
  String toString() => "\x1B[31mDigiaException : =>  $message\x1B[0m";
}
