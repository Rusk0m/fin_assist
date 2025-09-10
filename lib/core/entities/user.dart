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

  @override
  List<Object?> get props => [uid, email, name, role, organizations];
}
