class ConnectionException implements Exception {

  ConnectionException({
    this.message =
        'No Internet connection. Make sure Wifi or Cellular Data is turned on, then try again.',
  });
  final String message;

  @override
  String toString() => 'FormatException: $message';
}

class ManuallyException implements Exception {

  ManuallyException(this.message, {this.code});
  final int? code;
  final String message;

  @override
  String toString() => 'FormatException: $message';
}

class TokenExpiredException implements Exception {
  TokenExpiredException();
}

class ServerException implements Exception {

  ServerException(this.error, {this.code});
  final dynamic error;
  final int? code;
}

