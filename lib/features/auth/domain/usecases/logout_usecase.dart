import 'package:dartz/dartz.dart';
import 'package:fin_assist/core/error/failures.dart';
import 'package:fin_assist/features/auth/domain/repository/auth_repository.dart';

import 'check_auth_status_usecase.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() async {
    try {
      await repository.logOut();
    } catch (e) {
      ArgumentError( e.toString());
    }
  }
}

