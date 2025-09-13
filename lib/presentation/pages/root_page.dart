import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:fin_assist/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:fin_assist/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
      current is AuthAuthenticated || current is AuthUnauthenticated,
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(context, AppRouter.logIn,(route)=>false);
        } else if (state is AuthAuthenticated) {
          print("User Id: ${state.uid}");
          context.read<UserBloc>().add(LoadUser(state.uid));
          Navigator.pushNamedAndRemoveUntil(context, AppRouter.dashboard,(route)=>false);
        }
      },
      child: const Scaffold(),
    );
  }
}
