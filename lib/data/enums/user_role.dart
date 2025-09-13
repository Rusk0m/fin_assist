enum UserRole {
  owner,
  manager,
  accountant;

  String get toFirestore => name;

  static UserRole fromFirestore(String value) {
    return UserRole.values.firstWhere(
          (e) => e.name == value,
      orElse: () => UserRole.owner,
    );
  }

  String get displayName {
    switch (this) {
      case UserRole.owner:
        return 'Владелец';
      case UserRole.manager:
        return 'Менеджер';
      case UserRole.accountant:
        return 'Бухгалтер';
    }
  }
}