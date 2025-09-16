import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String role;
  final List<String> organizations;
  final List<String> branches;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    required this.organizations,
    required this.branches,
  });

  // Метод для преобразования объекта в Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'role': role,
      'organizations': organizations,
      'branches': branches,
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
      branches: List<String>.from(json['branches'] ?? []),
    );
  }

  UserEntity copyWith({
    String? email,
    String? name,
    String? role,
    List<String>? organizations,
    List<String>? branches,
  }) {
    return UserEntity(
      uid: uid,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      organizations: organizations ?? this.organizations,
      branches: branches ?? this.branches,
    );
  }

  @override
  List<Object?> get props => [uid, email, name, role, organizations, branches];
}
