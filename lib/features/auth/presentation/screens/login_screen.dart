import 'package:fin_assist/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fin_assist/features/auth/presentation/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(S.of(context).login)),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, '/dashboard_page');
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
                children: [
                  TextField(
                    controller: emailController,
                    decoration:  InputDecoration(labelText: S.of(context).email),
                  ),
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
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LoginWithGoogleEvent());
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
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/signup_page',(Route<dynamic> route) => false);
                    },
                    child: Text(S.of(context).noAccountRegister),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
