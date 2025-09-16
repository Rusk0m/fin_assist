import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_assist/domain/entity/user.dart';
import 'package:fin_assist/data/model/branch_model/branch_model.dart';
import 'package:fin_assist/data/model/organisation_model/organization_model.dart';
import 'package:fin_assist/data/model/user_model/user_model.dart';
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
          .map((doc) {
        final data = doc.data();
        // Добавляем branchId в данные
        final jsonWithId = {...data, 'branchId': doc.id};
        return BranchModel.fromJson(jsonWithId).toEntity();
      })
          .toList();
    } catch (e) {
      print('Error getting user branches: $e');
      throw Exception('Не удалось загрузить филиалы пользователя');
    }
  }

  @override
  Future<UserEntity> getUserById(String uid) async {
    try {
      final doc = await firestore.collection('users').doc(uid).get();
      if (!doc.exists) throw Exception('Профиль пользователя не найден');

      final data = doc.data()!;
      // Добавляем uid в данные
      final jsonWithId = {...data, 'uid': doc.id};
      return UserModel.fromJson(jsonWithId).toEntity();
    } catch (e) {
      print('Error getting user by ID: $e');
      throw Exception('Не удалось загрузить данные пользователя');
    }
  }

  @override
  Future<List<Organization>> getUserOrganization(String uid) async {
    try {
      final snapshot = await firestore
          .collection('organizations')
          .where('ownerId', isEqualTo: uid)
          .get();

      return snapshot.docs
          .map((doc) {
        final data = doc.data();
        // Добавляем organizationId в данные
        final jsonWithId = {...data, 'organizationId': doc.id};
        return OrganizationModel.fromJson(jsonWithId).toEntity();
      })
          .toList();
    } catch (e) {
      print('Error getting user organizations: $e');
      throw Exception('Не удалось загрузить организации пользователя');
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    try {
      // Преобразуем Entity в Model и затем в JSON
      final userModel = UserModel.fromEntity(user);
      await firestore.collection('users').doc(user.uid).update(userModel.toJson());
    } catch (e) {
      print('Error updating user: $e');
      throw Exception('Не удалось обновить данные пользователя');
    }
  }

  @override
  Future<void> addUser(UserEntity user) async {
    try {
      // Проверяем, существует ли пользователь
      final userDoc = await firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        throw Exception('Пользователь уже существует');
      }

      // Преобразуем Entity в Model и затем в JSON
      final userModel = UserModel.fromEntity(user);
      await firestore.collection('users').doc(user.uid).set(userModel.toJson());
    } catch (e) {
      print('Error adding user: $e');
      throw Exception('Не удалось создать пользователя: $e');
    }
  }

  // Дополнительные методы
  @override
  Future<void> addUserToOrganization(String userId, String organizationId) async {
    try {
      final user = await getUserById(userId);
      final updatedUser = user.copyWith(
        organizations: List<String>.from(user.organizations)..add(organizationId),
      );

      await updateUser(updatedUser);
    } catch (e) {
      print('Error adding user to organization: $e');
      throw Exception('Не удалось добавить пользователя в организацию');
    }
  }

  @override
  Future<void> removeUserFromOrganization(String userId, String organizationId) async {
    try {
      final user = await getUserById(userId);
      final updatedUser = user.copyWith(
        organizations: List<String>.from(user.organizations)..remove(organizationId),
      );

      await updateUser(updatedUser);
    } catch (e) {
      print('Error removing user from organization: $e');
      throw Exception('Не удалось удалить пользователя из организации');
    }
  }
}