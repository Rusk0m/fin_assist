import 'dart:async';
import 'package:fin_assist/domain/entity/user.dart';
import 'package:fin_assist/generated/l10n.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:fin_assist/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginScreen extends StatelessWidget {
  final getIt = GetIt.instance;
  late final UserBloc userBloc = getIt<UserBloc>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(S.of(context).login)),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated){
           // userBloc.add(LoadUser(state.uid));
            Navigator.pushReplacementNamed(context, '/');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthPasswordResetSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).passwordResetEmailSent)),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    decoration:  InputDecoration(labelText: S.of(context).email),
                  ),
                  SizedBox(height: 28,),
                  TextField(
                    controller: passwordController,
                    decoration:  InputDecoration(labelText: S.of(context).password),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        LoginWithEmailAndPassEvent(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    },
                    child: Text(S.of(context).login),
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      context.read<AuthBloc>().add(LoginWithGoogleEvent());

                      final authStream = context.read<AuthBloc>().stream;
                      StreamSubscription? subscription;

                      subscription = authStream.listen((authState) {
                        if (authState is AuthAuthenticated) {
                          final newUser = UserEntity(
                            uid: authState.uid,
                            email: "",
                            name: "",
                            // email: authState.email ?? '',
                            // name: authState.displayName ?? '',
                            role: 'owner',
                            organizations: [],
                            branches: [],
                          );

                          userBloc.add(AddUser(newUser));
                          subscription?.cancel();
                        }
                      });
                    },
                    child:  Text(S.of(context).signInWithGoogle),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        ForgotPasswordEvent(email: emailController.text),
                      );
                    },
                    child: Text(S.of(context).forgotPassword),
                  ),/*
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/signup_page',(Route<dynamic> route) => false);
                    },
                    child: Text(S.of(context).noAccountRegister),
                  ),*/
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
