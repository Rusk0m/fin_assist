import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/generated/l10n.dart';
import 'package:fin_assist/presentation/pages/analitics/duty_screen.dart';
import 'package:fin_assist/presentation/pages/analitics/liquidity_screen.dart';
import 'package:fin_assist/presentation/pages/analitics/ros_screen.dart';
import 'package:flutter/material.dart';

class AnalyticsPage extends StatefulWidget {
  final List<FinancialReportEntity> reports;

  const AnalyticsPage({super.key, required this.reports});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedPeriod = 12; // 3, 6, 12 месяцев
  final List<int> _periodOptions = [3, 6, 12];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<FinancialReportEntity> get _filteredReports {
    final sorted = List<FinancialReportEntity>.from(widget.reports)
      ..sort((a, b) => b.period.compareTo(a.period));

    return sorted.take(_selectedPeriod).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredReports = _filteredReports;

    if (filteredReports.isEmpty) {
      return const Center(
        child: Text('Нет данных для анализа'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).financialAnalysis),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              setState(() {
                _selectedPeriod = value;
              });
            },
            itemBuilder: (context) => _periodOptions.map((period) {
              return PopupMenuItem(
                value: period,
                child: Text(S.of(context).periodMonth(period)),
              );
            }).toList(),
            icon: const Icon(Icons.calendar_today),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings_page');
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs:  [
            Tab(text: S.of(context).profitability),
            Tab(text: S.of(context).liquidity),
            Tab(text: S.of(context).arrears),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          RosScreen(reports: filteredReports, period: _selectedPeriod),
          LiquidityScreen(reports: filteredReports, period: _selectedPeriod),
          DutyScreen(reports: filteredReports, period: _selectedPeriod),
        ],
      ),
    );
  }
}