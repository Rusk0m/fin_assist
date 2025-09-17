import 'package:fin_assist/presentation/blocs/dashboard_cubit/dashboard_cubit.dart';
import 'package:fin_assist/presentation/blocs/financial_report_bloc/financial_report_bloc.dart';
import 'package:fin_assist/presentation/pages/analitics/analytics_page.dart';
import 'package:fin_assist/presentation/pages/home_page.dart';
import 'package:fin_assist/presentation/pages/report_list/report_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: [
          const HomePage(),
          const ReportListPage(),
          _buildAnalyticsPage(context), // Изменено здесь
        ],
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
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics),
                label: 'Analytics'
            )
          ],
        ),
      ),
    );
  }

  // Новый метод для построения AnalyticsPage с данными
  Widget _buildAnalyticsPage(BuildContext context) {
    return BlocBuilder<FinancialReportBloc, FinancialReportState>(
      builder: (context, reportState) {
        if (reportState is FinancialReportsLoadedState) {
          return AnalyticsPage(reports: reportState.reports);
        } else if (reportState is FinancialReportErrorState) {
          return Center(child: Text('Error: ${reportState.message}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}