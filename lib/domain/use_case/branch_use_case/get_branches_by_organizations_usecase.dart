import 'package:fin_assist/domain/entity/branch.dart';
import 'package:fin_assist/domain/repository/branch_repository.dart';

class GetBranchesByOrganizationsUseCase {
  final BranchRepository branchRepository;

  GetBranchesByOrganizationsUseCase({required this.branchRepository});

  Future<List<Branch>?> call(String organizationId)async{
    try {
      return branchRepository.getBranchesByOrganization(organizationId);
    } catch (e) {
      print('Error: $e');
    }
  }
}