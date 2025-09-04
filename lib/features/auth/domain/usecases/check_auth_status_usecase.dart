import 'package:dartz/dartz.dart';
import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/core/error/failures.dart';
import 'package:fin_assist/features/auth/domain/repository/auth_repository.dart';

class CheckAuthStatusUseCase {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  Future<UserEntity?> call() async {
    try {
      final user = await repository.checkAuthStatus();
      return user;
    } catch (e) {
      throw ArgumentError(e.toString());
    }
  }
}

