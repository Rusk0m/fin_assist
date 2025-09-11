import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/data/model/branch_model/branch_model.dart';
import 'package:fin_assist/data/model/organisation_model/organization_model.dart';
import 'package:fin_assist/domain/entity/branch.dart';
import 'package:fin_assist/domain/entity/organization.dart';
import 'package:fin_assist/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;

  UserRepositoryImpl({required this.firestore});

  @override
  Future<List<Branch>> getUserBranches(String uid) async {
    try {
      final snapshot = await firestore
          .collection('branches')
          .where('managerId', isEqualTo: uid)
          .get();

      return snapshot.docs
          .map((doc) => BranchModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  Future<UserEntity> getUserById(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (!doc.exists) throw Exception('Профиль пользователя не найден');

    final data = doc.data()!;
    return UserEntity(
      uid: data['uid'],
      email: data['email'],
      name: data['name'],
      role: data['role'],
      organizations: List<String>.from(data['organizations'] ?? []),
    );
  }

  @override
  Future<List<Organization>> getUserOrganization(String uid) async {
    try {
      final snapshot = await firestore
          .collection('organizations')
          .where('ownerId', isEqualTo: uid)
          .get();

      return snapshot.docs
          .map((doc) => OrganizationModel.fromJson(doc.data()).toEntity())
          .toList();
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    try {
      await firestore.collection('users').doc(user.uid).update({
        'name': user.name,
        'email': user.email,
        'role': user.role,
        'organizations': user.organizations,
      });
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }
}