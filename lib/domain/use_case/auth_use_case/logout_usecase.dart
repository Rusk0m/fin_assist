
import 'package:fin_assist/domain/repository/auth_repository.dart';

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

