import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/domain/entity/branch.dart';
import 'package:fin_assist/domain/entity/organization.dart';

abstract class UserRepository {
  Future<UserEntity> getUserById(String uid);
  Future<List<Organization>> getUserOrganization(String uid);
  Future<List<Branch>> getUserBranches(String uid);
  Future<void> updateUser(UserEntity updatedUser);
  Future<void> addUser(UserEntity user);
}