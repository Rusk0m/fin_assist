import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/features/auth/domain/repository/auth_repository.dart';
import 'package:fin_assist/features/auth/domain/usecases/check_auth_status_usecase.dart';

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