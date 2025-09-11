import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/domain/repository/auth_repository.dart';

class GoogleLoginUseCase {
  final AuthRepository repository;

  GoogleLoginUseCase(this.repository);

  Future<UserEntity> call() async {
    try {
      final user = await repository.logInWithGoogle();
      return user;
    } catch (e) {
      throw ArgumentError(e);
    }
  }
}