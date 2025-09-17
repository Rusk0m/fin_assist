import 'package:fin_assist/domain/entity/economic_indicators.dart';
import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/domain/services/economic_indicators_service.dart';
import 'package:fin_assist/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RosScreen extends StatelessWidget {
  final List<FinancialReportEntity> reports;
  final int period;

  const RosScreen({super.key, required this.reports, required this.period});

  @override
  Widget build(BuildContext context) {
    final indicatorsService = EconomicIndicatorsService();
    final monthlyIndicators = reports.map((report) {
      return {
        'period': report.period,
        'indicators': indicatorsService.calculateIndicators(report),
        'report': report
      };
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).profitabilityAnalysisPeriodMonths,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // График ROA и ROE
          _buildROChart(monthlyIndicators,context),
          const SizedBox(height: 20),

          // График маржи
          _buildMarginChart(monthlyIndicators,context),
          const SizedBox(height: 20),

          // Ключевые показатели
          _buildKeyMetrics(indicatorsService.calculateAggregatedIndicators(reports),context),
          const SizedBox(height: 20),

          // Детальная таблица
          _buildDetailedTable(monthlyIndicators,context),
        ],
      ),
    );
  }

  Widget _buildROChart(List<Map<String, dynamic>> monthlyIndicators,BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).returnOnAssetsAndCapital,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  labelRotation: -45,
                ),
                series: <CartesianSeries>[
                  LineSeries<Map<String, dynamic>, String>(
                    dataSource: monthlyIndicators.reversed.toList(),
                    xValueMapper: (data, _) => data['period'],
                    yValueMapper: (data, _) => data['indicators'].returnOnAssets * 100,
                    name: 'ROA',
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                  LineSeries<Map<String, dynamic>, String>(
                    dataSource: monthlyIndicators.reversed.toList(),
                    xValueMapper: (data, _) => data['period'],
                    yValueMapper: (data, _) => data['indicators'].returnOnEquity * 100,
                    name: 'ROE',
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                ],
                legend: const Legend(isVisible: true),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarginChart(List<Map<String, dynamic>> monthlyIndicators,BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).profitMargin,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  labelRotation: -45,
                ),
                series: <CartesianSeries>[
                  LineSeries<Map<String, dynamic>, String>(
                    dataSource: monthlyIndicators.reversed.toList(),
                    xValueMapper: (data, _) => data['period'],
                    yValueMapper: (data, _) => data['indicators'].grossProfitMargin * 100,
                    name: S.of(context).GrossMargin,
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                  LineSeries<Map<String, dynamic>, String>(
                    dataSource: monthlyIndicators.reversed.toList(),
                    xValueMapper: (data, _) => data['period'],
                    yValueMapper: (data, _) => data['indicators'].netProfitMargin * 100,
                    name: S.of(context).netMargin,
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                ],
                legend: const Legend(isVisible: true),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetrics(EconomicIndicators indicators,BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            'ROA',
            '${(indicators.returnOnAssets * 100).toStringAsFixed(1)}%',
            Colors.blue,
            S.of(context).returnOnAssets,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            'ROE',
            '${(indicators.returnOnEquity * 100).toStringAsFixed(1)}%',
            Colors.green,
            S.of(context).returnOnCapital,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            S.of(context).margin,
            '${(indicators.netProfitMargin * 100).toStringAsFixed(1)}%',
            Colors.purple,
            S.of(context).netMargin,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, Color color, String subtitle) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
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
              style: const TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedTable(List<Map<String, dynamic>> monthlyIndicators, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).detailedStatistics,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text(S.of(context).period)),
                  DataColumn(label: Text('ROA (%)')),
                  DataColumn(label: Text('ROE (%)')),
                  DataColumn(label: Text(S.of(context).grossMargin)),
                  DataColumn(label: Text(S.of(context).netMargin)),
                  DataColumn(label: Text(S.of(context).revenue)),
                  DataColumn(label: Text(S.of(context).profit)),
                ],
                rows: monthlyIndicators.reversed.map((data) {
                  final indicators = data['indicators'] as EconomicIndicators;
                  final report = data['report'] as FinancialReportEntity;

                  return DataRow(cells: [
                    DataCell(Text(data['period'])),
                    DataCell(Text((indicators.returnOnAssets * 100).toStringAsFixed(1))),
                    DataCell(Text((indicators.returnOnEquity * 100).toStringAsFixed(1))),
                    DataCell(Text((indicators.grossProfitMargin * 100).toStringAsFixed(1))),
                    DataCell(Text((indicators.netProfitMargin * 100).toStringAsFixed(1))),
                    DataCell(Text(report.incomeStatement.revenue.toStringAsFixed(0))),
                    DataCell(Text(report.incomeStatement.netProfit.toStringAsFixed(0))),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}