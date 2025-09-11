import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/domain/repository/auth_repository.dart';

class GoogleLoginUseCase {
  final AuthRepository repository;

  GoogleLoginUseCase(this.repository);

  Future<String> call() async {
    try {
      final uid = await repository.logInWithGoogle();
      return uid;
    } catch (e) {
      throw ArgumentError(e);
    }
  }
}