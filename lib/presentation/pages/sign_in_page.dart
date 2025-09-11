import 'package:fin_assist/generated/l10n.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).registration)),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, '/dashboard_page');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
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
                    controller: nameController,
                    decoration: InputDecoration(labelText: S.of(context).name),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: S.of(context).email),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    decoration:  InputDecoration(labelText: S.of(context).password),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      final name = nameController.text.trim();
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
                        context.read<AuthBloc>().add(
                          RegisterEvent(
                            name: name,
                            email: email,
                            password: password,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(S.of(context).fillInAllFields)),
                        );
                      }
                    },
                    child: Text(S.of(context).register),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.login),
                    label: Text(S.of(context).signInWithGoogle),
                    onPressed: () {
                      context.read<AuthBloc>().add(LoginWithGoogleEvent());
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login_page');
                    },
                    child: Text(S.of(context).haveAnAccount),
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