import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:fin_assist/presentation/pages/dashboard_screen.dart';
import 'package:fin_assist/presentation/pages/login_screen.dart';
import 'package:fin_assist/presentation/pages/report_list/repotrt_details_page.dart';
import 'package:fin_assist/presentation/pages/report_selection_page/reports_page.dart';
import 'package:fin_assist/presentation/pages/root_page.dart';
import 'package:fin_assist/presentation/pages/settings/change_password_page.dart';
import 'package:fin_assist/presentation/pages/settings/profile_details_page.dart';
import 'package:fin_assist/presentation/pages/settings/settings_page.dart';
import 'package:fin_assist/presentation/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String home = '/';
  static const String signIn = '/signup_page';
  static const String logIn = '/login_page';
  static const String dashboard = '/dashboard_page';
  static const String settingsPage = '/settings_page';
  static const String changePassword = '/change_password_page';
  static const String profileDetails = '/profile_details_page';
  static const String reportSelection = '/report_selection_page';
  static const String reportDetails = '/report_detail_page';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const RootPage());
      case signIn:
        return MaterialPageRoute(builder: (_) => SignInPage());
      case logIn:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case settingsPage:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordPage());
      case profileDetails:
        return MaterialPageRoute(builder: (_) => const ProfileDetailsPage());
      case reportSelection:
        return MaterialPageRoute(builder: (_) => const ReportSelectionPage());
      case reportDetails:
        final report = settings.arguments as FinancialReportEntity;
        return MaterialPageRoute(
          builder: (_) => DetailReportPage(report: report),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Маршрут  ${settings.name} не найден')),
          ),
        );
    }
  }
}
