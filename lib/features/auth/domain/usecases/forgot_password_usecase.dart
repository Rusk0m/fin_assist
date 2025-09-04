import 'package:dartz/dartz.dart';
import 'package:fin_assist/core/error/failures.dart';
import 'package:fin_assist/features/auth/domain/repository/auth_repository.dart';

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