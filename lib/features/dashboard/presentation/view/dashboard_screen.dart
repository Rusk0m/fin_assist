import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fin_assist/di.dart';
import 'package:fin_assist/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fin_assist/features/dashboard/presentation/cubit/dashboard_cubit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select(
          (DashboardCubit cubit) => cubit.state.tab,
    );
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print('DashboardView: State changed to $state');
        if (state is AuthUnauthenticated) {
          print('DashboardView: Navigating to /login_page');
          Navigator.of(context).pushReplacementNamed('/login_page');
        } else if (state is AuthError) {
          print('DashboardView: Auth error: ${state.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hello'),
          leading: IconButton(
            onPressed: () {
              print('DashboardView: Logout button pressed');
              context.read<AuthBloc>().add(LogoutEvent());
            },
            icon: const Icon(Icons.logout),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.blueAccent,
            child: const Center(
              child: Text(
                'Dashboard Content',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 1.5)),
          ),
          child: BottomNavigationBar(
            currentIndex: selectedTab.index,
            onTap: (index) {
              context.read<DashboardCubit>().setTab(DashboardTab.values[index]);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}