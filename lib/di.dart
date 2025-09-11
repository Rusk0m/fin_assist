import 'package:fin_assist/domain/repository/auth_repository.dart';
import 'package:fin_assist/data/repository/auth_repository_impl.dart';
import 'package:fin_assist/domain/use_case/auth_use_case/check_auth_status_usecase.dart';
import 'package:fin_assist/domain/use_case/auth_use_case/forgot_password_usecase.dart';
import 'package:fin_assist/domain/use_case/auth_use_case/google_login_usecase.dart';
import 'package:fin_assist/domain/use_case/auth_use_case/login_usecase.dart';
import 'package:fin_assist/domain/use_case/auth_use_case/logout_usecase.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart' show AuthBloc;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';


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
  //getIt.registerSingleton<RegisterUseCase>(RegisterUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<LogoutUseCase>(LogoutUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<CheckAuthStatusUseCase>(CheckAuthStatusUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<ForgotPasswordUseCase>(ForgotPasswordUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<GoogleLoginUseCase>(GoogleLoginUseCase(getIt<AuthRepository>()));

  // BLoC
  getIt.registerSingleton<AuthBloc>(AuthBloc(repository: getIt<AuthRepository>()));

}