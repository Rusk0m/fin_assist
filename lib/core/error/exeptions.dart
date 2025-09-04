
class AuthException implements Exception {
final String message;

AuthException(this.message);

@override
String toString() => 'AuthException: $message';
}

class ServerException implements Exception {
final String message;

ServerException(this.message);

@override
String toString() => 'ServerException: $message';
}
