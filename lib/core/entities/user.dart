import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String? name;
  final String role;
  final List<String> organizations;

  const UserEntity({
    required this.uid,
    required this.email,
    this.name,
    required this.role,
    required this.organizations,
  });

  // Метод для преобразования объекта в Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'role': role,
      'organizations': organizations,
    };
  }

  // Фабричный метод для создания объекта из Map (JSON)
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      name: json['name'],
      role: json['role'] ?? '',
      organizations: List<String>.from(json['organizations'] ?? []),
    );
  }

  @override
  List<Object?> get props => [uid, email, name, role, organizations];
}
