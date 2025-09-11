import 'package:fin_assist/domain/entity/organization.dart';
import 'package:fin_assist/domain/repository/user_repository.dart';

class GetUserOrganizationUseCase {
  final UserRepository userRepository;

  GetUserOrganizationUseCase({required this.userRepository});

  Future<List<Organization>> call (String uid) async {
    try {
      return userRepository.getUserOrganization(uid);
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}