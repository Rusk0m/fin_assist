import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:fin_assist/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final userBloc = context.read<UserBloc>();

    if (userBloc.state is UserInitial) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        userBloc.add(LoadUser(authState.uid));
      }
    }
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading || state is UserInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is UserLoaded) {
          return HomeView(user: state.user);
        } else if (state is UserError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class HomeView extends StatelessWidget {
  final UserEntity user;
  const HomeView({
    super.key, required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(children: [const Text('Hello'),Text('${user.name}')]),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/settings_page');
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: Center(child: Text('Home Page')),
    );
  }
}
