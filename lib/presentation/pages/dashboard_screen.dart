import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:fin_assist/presentation/blocs/dashboard_cubit/dashboard_cubit.dart';
import 'package:fin_assist/presentation/pages/analytics_page.dart';
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
          HomePage(),
          ReportListPage(),
          AnalyticsPage(),
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
            BottomNavigationBarItem(icon: Icon(Icons.analytics),label: 'Analytics')
          ],
        ),
      ),
    );
  }
}
