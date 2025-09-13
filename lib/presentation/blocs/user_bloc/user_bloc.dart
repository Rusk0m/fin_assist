import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/domain/repository/user_repository.dart';
import 'package:fin_assist/domain/use_case/user_use_case/add_user_usecase.dart';
import 'package:get_it/get_it.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);
    on<AddUser>(_onAddUser);
  }

  Future<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await userRepository.getUserById(event.uid);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError('Не удалось загрузить профиль: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserUpdating());
    try {
      // Сохраняем изменения через UserRepository
      await userRepository.updateUser(event.updatedUser);

      // Загружаем обновленный профиль
      final updatedUser = await userRepository.getUserById(event.updatedUser.uid);
      emit(UserUpdated(updatedUser));
    } catch (e) {
      emit(UserError('Не удалось обновить профиль: ${e.toString()}'));
    }
  }

  Future<void> _onAddUser(AddUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await GetIt.instance<AddUserUseCase>().call(event.user);

      // Загружаем созданного пользователя
      final newUser = await userRepository.getUserById(event.user.uid);
      emit(UserLoaded(newUser));
    } catch (e) {
      emit(UserError('Не удалось создать пользователя: ${e.toString()}'));
    }
  }
}

