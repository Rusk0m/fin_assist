import 'package:fin_assist/domain/entity/user.dart';
import 'package:fin_assist/domain/repository/user_repository.dart';

class AddUserUseCase {
  final UserRepository userRepository;

  AddUserUseCase({required this.userRepository});

  Future<void> call(UserEntity user) {
    return userRepository.addUser(user);
  }
}