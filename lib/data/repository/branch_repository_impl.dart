import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_assist/domain/repository/branch_repository.dart';
import '../../domain/entity/branch.dart';
import '../model/branch_model/branch_model.dart';

class BranchRepositoryImpl implements BranchRepository {
  final FirebaseFirestore firestore;

  BranchRepositoryImpl(this.firestore);

  @override
  Future<void> addBranch(Branch branch) async {
    final docRef = firestore.collection('branches').doc(branch.branchId);
    await docRef.set(BranchModel(
      branchId: branch.branchId,
      name: branch.name,
      address: branch.address,
      managerId: branch.managerId,
      notes: branch.notes,
      createdAt: branch.createdAt,
      organizationId: branch.organizationId,
    ).toJson());
  }

  @override
  Future<Branch?> getBranchById(String branchId) async {
    final doc = await firestore.collection('branches').doc(branchId).get();
    if (!doc.exists) return null;
    return BranchModel.fromJson(doc.data()!).toEntity();
  }

  @override
  Future<List<Branch>> getBranchesByOrganization(String organizationId) async {
    final query = await firestore.collection('branches')
        .where('organizationId', isEqualTo: organizationId)
        .get();
    return query.docs.map((doc) => BranchModel.fromJson(doc.data()).toEntity()).toList();
  }
}
