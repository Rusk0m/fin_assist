import 'package:fin_assist/domain/entity/branch.dart';
import 'package:fin_assist/domain/repository/branch_repository.dart';

class GetBranchByIdUseCase {
  final BranchRepository branchRepository;

  GetBranchByIdUseCase({required this.branchRepository});

  Future<Branch?> call(String branchId) async {
    try {
      return branchRepository.getBranchById(branchId);
    } catch (e) {
      print('Error: $e');
    }
  }
}