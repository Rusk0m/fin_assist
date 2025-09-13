import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String uid;
  final String email;
  final String name;
  final String role;
  final List<String> organizations;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    required this.organizations,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
