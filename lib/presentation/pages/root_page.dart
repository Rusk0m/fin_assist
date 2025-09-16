import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:fin_assist/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:fin_assist/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Слушаем AuthBloc
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUnauthenticated) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouter.logIn,
                    (route) => false,
              );
            } else if (state is AuthAuthenticated) {
              // Загружаем пользователя
              context.read<UserBloc>().add(LoadUser(state.uid));
            }
          },
        ),
        // Слушаем UserBloc
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoaded) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/report_selection_page',
                    (route) => false,
              );
            }
          },
        ),
      ],
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()), // индикатор пока грузим
      ),
    );
  }
}
