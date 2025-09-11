import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<String> call(LoginParams params) async {
    try {
      final uid = await repository.logInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      return uid;
    } catch (e) {
      throw ArgumentError(e.toString()) ;
    }
  }
}
class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
