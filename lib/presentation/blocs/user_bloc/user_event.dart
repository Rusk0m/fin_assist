part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Загрузка профиля по uid
class LoadUser extends UserEvent {
  final String uid;
  LoadUser(this.uid);

  @override
  List<Object?> get props => [uid];
}

// Обновление информации пользователя
class UpdateUser extends UserEvent {
  final UserEntity updatedUser;
  UpdateUser(this.updatedUser);

  @override
  List<Object?> get props => [updatedUser];
}
class ClearUser extends UserEvent {}
