import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/domain/repository/user_repository.dart';

class GetUserByIdUseCase {
  final UserRepository userRepository;

  GetUserByIdUseCase({required this.userRepository});

  Future<UserEntity?> call(String uid) async {
    try {
      return userRepository.getUserById(uid);
    } catch (e) {
      print('Error: $e');
    }
  }
}