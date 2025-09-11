import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:fin_assist/presentation/pages/dashboard_screen.dart';
import 'package:fin_assist/presentation/pages/login_screen.dart';
import 'package:fin_assist/presentation/pages/settings_page.dart';
import 'package:fin_assist/presentation/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static const String home = '/';
  static const String signIn = '/signup_page';
  static const String logIn = '/login_page';
  static const String dashboard = '/dashboard_page';
  static const String settings_page = '/settings_page';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              print('AppRouter: Current state for home route: $state');
              if (state is AuthAuthenticated) {
                return const DashboardScreen();
              } else {
                return LoginScreen();
              }
            },
          ),
        );
      case signIn:
        return MaterialPageRoute(builder: (_) => SignInPage());
      case logIn:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case settings_page:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Маршрут  ${settings.name} не найден')),
          ),
        );
    }
  }
}
