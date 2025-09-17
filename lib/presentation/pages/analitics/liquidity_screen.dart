import 'package:fin_assist/domain/entity/economic_indicators.dart';
import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/domain/services/economic_indicators_service.dart';
import 'package:fin_assist/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LiquidityScreen extends StatelessWidget {
  final List<FinancialReportEntity> reports;
  final int period;

  const LiquidityScreen({super.key, required this.reports, required this.period});

  @override
  Widget build(BuildContext context) {
    final indicatorsService = EconomicIndicatorsService();
    final monthlyData = reports.map((report) {
      final indicators = indicatorsService.calculateIndicators(report);
      return _LiquidityChartData(
        period: report.period,
        currentRatio: indicators.liquidityRatio,
        quickRatio: indicators.quickRatio,
        cash: report.balance.cash,
        currentAssets: report.balance.currentAssets,
        shortTermLiabilities: report.balance.shortTermLiabilities,
      );
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).liquidityAnalysisPeriodMonths,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // График ликвидности
          _buildLiquidityChart(monthlyData,context),
          const SizedBox(height: 20),

          // Ключевые показатели
          _buildKeyMetrics(indicatorsService.calculateAggregatedIndicators(reports),context),
          const SizedBox(height: 20),

          // Детальная таблица
          _buildDetailedTable(monthlyData,context),
        ],
      ),
    );
  }

  Widget _buildLiquidityChart(List<_LiquidityChartData> monthlyData, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).liquidityRatios,
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
                  LineSeries<_LiquidityChartData, String>(
                    dataSource: monthlyData.reversed.toList(),
                    xValueMapper: (_LiquidityChartData data, _) => data.period,
                    yValueMapper: (_LiquidityChartData data, _) => data.currentRatio,
                    name: S.of(context).currentLiquidity,
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                  LineSeries<_LiquidityChartData, String>(
                    dataSource: monthlyData.reversed.toList(),
                    xValueMapper: (_LiquidityChartData data, _) => data.period,
                    yValueMapper: (_LiquidityChartData data, _) => data.quickRatio,
                    name: S.of(context).fastLiquidity,
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
            S.of(context).techLiquor,
            indicators.liquidityRatio.toStringAsFixed(2),
            indicators.liquidityRatio > 2 ? Colors.green : Colors.orange,
            S.of(context).currentLiquidityRatio,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            S.of(context).fastLiquor,
            indicators.quickRatio.toStringAsFixed(2),
            indicators.quickRatio > 1 ? Colors.green : Colors.orange,
            S.of(context).quickLiquidityRatio,
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

  Widget _buildDetailedTable(List<_LiquidityChartData> monthlyData,BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).detailedLiquidityStatistics,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns:  [
                  DataColumn(label: Text(S.of(context).period)),
                  DataColumn(label: Text(S.of(context).techLiquor)),
                  DataColumn(label: Text(S.of(context).fastLiquor)),
                  DataColumn(label: Text(S.of(context).cashResources)),
                  DataColumn(label: Text(S.of(context).techAssets)),
                  DataColumn(label: Text(S.of(context).brieflyMust)),
                ],
                rows: monthlyData.reversed.map((data) {
                  return DataRow(cells: [
                    DataCell(Text(data.period)),
                    DataCell(Text(data.currentRatio.toStringAsFixed(2))),
                    DataCell(Text(data.quickRatio.toStringAsFixed(2))),
                    DataCell(Text(data.cash.toStringAsFixed(0))),
                    DataCell(Text(data.currentAssets.toStringAsFixed(0))),
                    DataCell(Text(data.shortTermLiabilities.toStringAsFixed(0))),
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

class _LiquidityChartData {
  final String period;
  final double currentRatio;
  final double quickRatio;
  final double cash;
  final double currentAssets;
  final double shortTermLiabilities;

  _LiquidityChartData({
    required this.period,
    required this.currentRatio,
    required this.quickRatio,
    required this.cash,
    required this.currentAssets,
    required this.shortTermLiabilities,
  });
}