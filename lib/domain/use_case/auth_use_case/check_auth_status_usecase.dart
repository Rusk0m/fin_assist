import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/domain/repository/auth_repository.dart';

class CheckAuthStatusUseCase {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  Future<String?> call() async {
    try {
      final uid = await repository.checkAuthStatus();
      return uid;
    } catch (e) {
      throw ArgumentError(e.toString());
    }
  }
}

