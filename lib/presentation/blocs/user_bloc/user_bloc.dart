import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/di.dart';
import 'package:fin_assist/domain/use_case/user_use_case/get_user_by_id_usecase.dart';
import 'package:fin_assist/domain/use_case/user_use_case/update_user_usecase.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserByIdUseCase getUserUseCase;
  late final StreamSubscription authSubscription;

  UserBloc({
    required this.getUserUseCase,
    required AuthBloc authBloc,
  }) : super(UserInitial()) {
    // Подписываемся на AuthBloc
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

  void _onClearUser(ClearUser event, Emitter<UserState> emit) {
    emit(UserInitial());
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}

