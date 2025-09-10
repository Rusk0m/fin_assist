/*
import 'package:dartz/dartz.dart';
import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/core/error/failures.dart';
import 'package:fin_assist/features/auth/domain/repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserEntity> call(RegisterParams params) async {
    try {
      final user = await repository.registration(
        name: params.name,
        email: params.email,
        password: params.password,
      );
      return user;
    } catch (e) {
      throw ArgumentError(e.toString()) ;
    }
  }
}
class RegisterParams {
  final String name;
  final String email;
  final String password;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
*/
