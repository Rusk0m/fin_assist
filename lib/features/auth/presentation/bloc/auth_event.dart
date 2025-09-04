part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginWithEmailAndPassEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginWithEmailAndPassEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class LoginWithGoogleEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

class LogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class CheckAuthStatusEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent({required this.email});

  @override
  List<Object?> get props => throw UnimplementedError();
}
