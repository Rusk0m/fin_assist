import 'package:fin_assist/domain/entity/branch.dart';
import 'package:fin_assist/domain/repository/user_repository.dart';

class GetUserBranchesUseCase {
  final UserRepository userRepository;

  GetUserBranchesUseCase({required this.userRepository});

  Future<List<Branch>> call(String uid) async {
    try {
      return userRepository.getUserBranches(uid);
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}