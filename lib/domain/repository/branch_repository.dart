import 'package:fin_assist/domain/entity/branch.dart';

abstract class BranchRepository {
  /// Получить филиал по ID
  Future<Branch?> getBranchById(String branchId);

  /// Получить все филиалы организации
  Future<List<Branch>> getBranchesByOrganization(String organizationId);

  /// Добавить новый филиал
  Future<void> addBranch(Branch branch);
}

