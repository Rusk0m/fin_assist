abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure({required String message}) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure({required String message}) : super(message);
}

class AuthFailure extends Failure {
  AuthFailure({required String message}) : super(message);
}