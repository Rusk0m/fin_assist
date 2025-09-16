import 'package:fin_assist/domain/entity/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String uid;
  final String email;
  final String name;
  final String role;
  final List<String> organizations;
  final List<String> branches;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    required this.organizations,
    required this.branches,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      email: entity.email,
      name: entity.name,
      role: entity.role,
      organizations: entity.organizations,
      branches: entity.branches,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      email: email,
      name: name,
      role: role,
      organizations: organizations,
      branches: branches,
    );
  }

  UserModel copyWith({
    String? email,
    String? name,
    String? role,
    List<String>? organizations,
    List<String>? branches,
  }) {
    return UserModel(
      uid: uid,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      organizations: organizations ?? this.organizations,
      branches: branches ?? this.branches,
    );
  }
}
