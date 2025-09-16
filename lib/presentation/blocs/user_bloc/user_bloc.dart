import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_assist/domain/entity/user.dart';
import 'package:fin_assist/domain/repository/user_repository.dart';
import 'package:fin_assist/domain/use_case/user_use_case/add_user_usecase.dart';
import 'package:fin_assist/domain/use_case/user_use_case/update_user_usecase.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../di.dart';
import '../../../domain/use_case/user_use_case/get_user_by_id_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  late final StreamSubscription authSubscription;

  UserBloc({
    required this.userRepository,
    required AuthBloc authBloc,
  }) : super(UserInitial()) {
    authSubscription = authBloc.stream.listen((authState) {
      if (authState is AuthAuthenticated) {
        add(LoadUser(authState.uid));
      } else if (authState is AuthUnauthenticated) {
        add(ClearUser());
      }
    });
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);
    on<ClearUser>(_onClearUser);
    on<AddUser>(_onAddUser);
  }

  Future<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await getIt<GetUserByIdUseCase>().call(event.uid);
      emit(UserLoaded(user!));
    } catch (e) {
      emit(UserError('Не удалось загрузить профиль: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserUpdating());
    try {
      // Сохраняем изменения через UserRepository
      await getIt<UpdateUserUseCase>().call(event.updatedUser);

      // Загружаем обновленный профиль
      final updatedUser = await getIt<GetUserByIdUseCase>().call(event.updatedUser.uid);
      emit(UserUpdated(updatedUser!));
    } catch (e) {
      emit(UserError('Не удалось обновить профиль: ${e.toString()}'));
    }
  }

  Future<void> _onAddUser(AddUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await GetIt.instance<AddUserUseCase>().call(event.user);

      final newUser = await userRepository.getUserById(event.user.uid);
      emit(UserLoaded(newUser));
      emit(UserLoaded(newUser as UserEntity));
    } catch (e) {
      emit(UserError('Не удалось создать пользователя: ${e.toString()}'));
    }
  }

  void _onClearUser(ClearUser event, Emitter<UserState> emit) {
    emit(UserInitial());
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}

