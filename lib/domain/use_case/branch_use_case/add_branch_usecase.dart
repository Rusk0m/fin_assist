import 'package:fin_assist/domain/entity/branch.dart';
import 'package:fin_assist/domain/repository/branch_repository.dart';

class AddBranchUseCase {
  final BranchRepository branchRepository;

  AddBranchUseCase({required this.branchRepository});

  Future<void> call(Branch branch) async {
    try {
      branchRepository.addBranch(branch);
    } catch (e) {
      print('Error: $e');
    }
  }
}
