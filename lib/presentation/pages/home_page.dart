import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/domain/entity/economic_indicators.dart';
import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/domain/services/economic_indicators_service.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:fin_assist/presentation/blocs/dashboard_cubit/dashboard_cubit.dart';
import 'package:fin_assist/presentation/blocs/financial_report_bloc/financial_report_bloc.dart';
import 'package:fin_assist/presentation/blocs/selection_bloc/selection_bloc.dart';
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

    // Загружаем отчеты при открытии домашней страницы
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final branchId = context.read<SelectionBloc>().state.selectedBranch?.branchId;
      if (branchId != null) {
        context.read<FinancialReportBloc>().add(GetReportsByBranchEvent(branchId));
      }
    });

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
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancialReportBloc, FinancialReportState>(
      builder: (context, reportState) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Добро пожаловать,',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  user.name!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).pushNamed('/settings_page');
                },
              ),
            ],
          ),
          body: _buildBody(context, reportState),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, FinancialReportState reportState) {
    if (reportState is FinancialReportLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (reportState is FinancialReportErrorState) {
      return Center(child: Text('Ошибка загрузки отчетов: ${reportState.message}'));
    } else if (reportState is FinancialReportsLoadedState) {
      return HomeDashboard(user: user, reports: reportState.reports);
    } else {
      return const Center(child: Text('Нет данных для отображения'));
    }
  }
}

class HomeDashboard extends StatelessWidget {
  final UserEntity user;
  final List<FinancialReportEntity> reports;

  const HomeDashboard({
    super.key,
    required this.user,
    required this.reports
  });

  @override
  Widget build(BuildContext context) {
    final sortedReports = List<FinancialReportEntity>.from(reports)
      ..sort((a, b) => b.period.compareTo(a.period));

    final latestReport = sortedReports.isNotEmpty ? sortedReports.first : null;

    if (latestReport == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.description, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Нет отчетов за предыдущий период',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    final indicators = EconomicIndicatorsService().calculateIndicators(latestReport);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок с периодом
          _buildHeader(latestReport.period),
          const SizedBox(height: 20),

          // Ключевые финансовые показатели
          _buildFinancialMetrics(latestReport, indicators),
          const SizedBox(height: 20),

          // Показатели ликвидности
          _buildLiquidityMetrics(indicators),
          const SizedBox(height: 20),

          // Показатели рентабельности
          _buildProfitabilityMetrics(indicators),
          const SizedBox(height: 20),

          // Показатели задолженности
          _buildDebtMetrics(indicators),
          const SizedBox(height: 20),

          // Кнопка быстрого перехода
          //_buildQuickActions(context),
        ],
      ),
    );
  }

  Widget _buildHeader(String period) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.blue),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Последний отчетный период',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    period,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialMetrics(FinancialReportEntity report, EconomicIndicators indicators) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📊 Основные финансовые показатели',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildMetricItem(
                    'Выручка',
                    '${report.incomeStatement.revenue.toStringAsFixed(0)} ₽',
                    Colors.green,
                    Icons.trending_up,
                  ),
                ),
                Expanded(
                  child: _buildMetricItem(
                    'Чистая прибыль',
                    '${report.incomeStatement.netProfit.toStringAsFixed(0)} ₽',
                    report.incomeStatement.netProfit >= 0 ? Colors.green : Colors.red,
                    Icons.attach_money,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildMetricItem(
                    'Себестоимость',
                    '${report.incomeStatement.cogs.toStringAsFixed(0)} ₽',
                    Colors.orange,
                    Icons.inventory,
                  ),
                ),
                Expanded(
                  child: _buildMetricItem(
                    'Денежный поток',
                    '${report.cashFlow.operating.toStringAsFixed(0)} ₽',
                    report.cashFlow.operating >= 0 ? Colors.blue : Colors.red,
                    Icons.account_balance_wallet,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiquidityMetrics(EconomicIndicators indicators) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '💧 Показатели ликвидности',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildIndicatorCard(
                    'Текущая ликвидность',
                    indicators.liquidityRatio.toStringAsFixed(2),
                    indicators.liquidityRatio > 2 ? Colors.green :
                    indicators.liquidityRatio > 1 ? Colors.orange : Colors.red,
                    'Норма: > 2.0',
                  ),
                ),
                Expanded(
                  child: _buildIndicatorCard(
                    'Быстрая ликвидность',
                    indicators.quickRatio.toStringAsFixed(2),
                    indicators.quickRatio > 1 ? Colors.green :
                    indicators.quickRatio > 0.5 ? Colors.orange : Colors.red,
                    'Норма: > 1.0',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfitabilityMetrics(EconomicIndicators indicators) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📈 Рентабельность',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildIndicatorCard(
                    'ROA',
                    '${(indicators.returnOnAssets * 100).toStringAsFixed(1)}%',
                    indicators.returnOnAssets > 0.05 ? Colors.green : Colors.red,
                    'Рентабельность активов',
                  ),
                ),
                Expanded(
                  child: _buildIndicatorCard(
                    'ROE',
                    '${(indicators.returnOnEquity * 100).toStringAsFixed(1)}%',
                    indicators.returnOnEquity > 0.1 ? Colors.green : Colors.red,
                    'Рентабельность капитала',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDebtMetrics(EconomicIndicators indicators) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🏦 Финансовая устойчивость',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildIndicatorCard(
              'Долг/Капитал',
              indicators.debtToEquity.toStringAsFixed(2),
              indicators.debtToEquity < 1 ? Colors.green :
              indicators.debtToEquity < 2 ? Colors.orange : Colors.red,
              'Норма: < 1.0',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(String title, String value, Color color, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildIndicatorCard(String title, String value, Color color, String subtitle) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /*Widget _buildQuickActions(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🚀 Быстрые действия',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    context,
                    'Вся аналитика',
                    Icons.analytics,
                    Colors.blue,
                        () {
                      context.read<DashboardCubit>().setTab(DashboardTab.analytics);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    context,
                    'Все отчеты',
                    Icons.list_alt,
                    Colors.green,
                        () {
                      context.read<DashboardCubit>().setTab(DashboardTab.reports);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }*/

  Widget _buildActionButton(BuildContext context, String text, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}