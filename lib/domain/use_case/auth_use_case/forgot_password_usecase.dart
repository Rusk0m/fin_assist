
import 'package:fin_assist/domain/repository/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future< void> call(String email) async {
    try {
      await repository.forgotPassword(email: email);
    } catch (e) {
      throw ArgumentError(e.toString());
    }
  }
}