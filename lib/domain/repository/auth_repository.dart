import 'package:fin_assist/domain/entity/user.dart';

abstract class AuthRepository {
  /*Future<UserEntity> registration({
    required String name,
    required String email,
    required String password,
  });*/

  Future<String> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<String> logInWithGoogle();

  Future<void> logOut();

  Future<String?> checkAuthStatus();

  Future<void> forgotPassword({required String email});
}
