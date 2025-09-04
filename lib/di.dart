
import 'package:dio/dio.dart';
import 'package:fin_assist/features/auth/domain/repository/auth_repository.dart';
import 'package:fin_assist/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/domain/usecases/usecases.dart';

final getIt = GetIt.instance;

void setupDependencies() async {

  getIt.registerSingleton<firebase_auth.FirebaseAuth>(firebase_auth.FirebaseAuth.instance);
  getIt.registerSingleton<GoogleSignIn>(GoogleSignIn());

  // Repository
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      firebaseAuth: getIt<firebase_auth.FirebaseAuth>(),
      googleSignIn: getIt<GoogleSignIn>(),
    ),
  );
  //Use cases
  //Auth use-case
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<RegisterUseCase>(RegisterUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<LogoutUseCase>(LogoutUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<CheckAuthStatusUseCase>(CheckAuthStatusUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<ForgotPasswordUseCase>(ForgotPasswordUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<GoogleLoginUseCase>(GoogleLoginUseCase(getIt<AuthRepository>()));

  // BLoC
  getIt.registerSingleton<AuthBloc>(AuthBloc(repository: getIt<AuthRepository>()));

}