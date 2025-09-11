import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/domain/repository/repositories.dart';

class UpdateUserUseCase {
  final UserRepository userRepository;

  UpdateUserUseCase({required this.userRepository});

  Future<void> call(UserEntity updatedUser) async {
    try {
      userRepository.updateUser(updatedUser);
    } catch (e) {
      print('Error: $e');
    }
  }
}