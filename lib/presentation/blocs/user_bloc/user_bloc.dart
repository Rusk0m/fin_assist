import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/di.dart';
import 'package:fin_assist/domain/use_case/user_use_case/get_user_by_id_usecase.dart';
import 'package:fin_assist/domain/use_case/user_use_case/update_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  UserBloc() : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);
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
}

