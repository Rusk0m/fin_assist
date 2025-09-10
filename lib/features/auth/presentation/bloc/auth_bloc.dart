import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/di.dart';
import 'package:fin_assist/features/auth/domain/repository/auth_repository.dart';
import 'package:fin_assist/features/auth/domain/usecases/usecases.dart';

import '../../../../core/error/failures.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    //on<RegisterEvent>(_onRegister);
    on<LoginWithEmailAndPassEvent>(_onLoginWithEmailAndPass);
    on<LoginWithGoogleEvent>(_onLoginWithGoogle);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<ForgotPasswordEvent>(_onForgotPassword);
  }

 /* Future<void> _onRegister(RegisterEvent event, Emitter emit) async {
    emit(AuthLoading());
    try {
      print('AuthBLoc: Register request for email: ${event.email}');

      final user = await getIt<RegisterUseCase>().call(
        RegisterParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      print('AuthBloc: Register error: $e');
      emit(AuthError(message: e.toString()));
    }
  }*/

  Future<void> _onLoginWithEmailAndPass(
    LoginWithEmailAndPassEvent event,
    Emitter emit,
  ) async {
    emit(AuthLoading());
    try {
      print('AuthBloc: Login request for email: ${event.email}');
      final user = await getIt<LoginUseCase>().call(
        LoginParams(email: event.email, password: event.password),
      );
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      print('AuthBloc: Login with email and password error: $e');
      emit(AuthError(message: e.toString()));
    }
  }

  FutureOr<void> _onLoginWithGoogle(
    LoginWithGoogleEvent event,
    Emitter emit,
  ) async {
    emit(AuthLoading());
    try {
      print('AuthBloc: Login with Google');
      final user = await getIt<GoogleLoginUseCase>().call();

      emit(AuthAuthenticated(user: user));
    } catch (e) {
      print('AuthBloc: Login with Google error: $e');
      emit(AuthError(message: e.toString()));
    }
  }

  FutureOr<void> _onLogout(LogoutEvent event, Emitter emit) async {
    emit(AuthLoading());
    try {
      print('AuthBloc: Logout request');
      await getIt<LogoutUseCase>().call();
      print('AuthBloc: Logout successful, emitting AuthUnauthenticated');
      emit(AuthUnauthenticated());
    } catch (e) {
      print('AuthBloc: Logout error: $e');
      emit(AuthError(message: e.toString()));
    }
  }

  FutureOr<void> _onCheckAuthStatus(CheckAuthStatusEvent event, Emitter emit) async{
    emit(AuthLoading());
    try {
      final user = await getIt<CheckAuthStatusUseCase>().call();
      if(user!=null){
        emit(AuthAuthenticated(user: user));
      }
      else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      print('AuthBloc: Check auth status error: $e');
      emit(AuthError(message: e.toString()));
    }
  }

  FutureOr<void> _onForgotPassword(ForgotPasswordEvent event, Emitter emit) async {
    emit(AuthLoading());
    try {
      print('AuthBloc: Forgot password request for email: ${event.email}');
      await getIt<ForgotPasswordUseCase>().call(event.email);
      emit(AuthPasswordResetSent());
    } catch (e) {
      print('AuthBloc: Forgot password error: $e');
      emit(AuthError(message: e.toString()));
    }
  }
}
