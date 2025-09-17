import 'package:fin_assist/domain/entity/economic_indicators.dart';
import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/domain/services/economic_indicators_service.dart';
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
            'Анализ ликвидности ($period месяцев)',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // График ликвидности
          _buildLiquidityChart(monthlyData),
          const SizedBox(height: 20),

          // Ключевые показатели
          _buildKeyMetrics(indicatorsService.calculateAggregatedIndicators(reports)),
          const SizedBox(height: 20),

          // Детальная таблица
          _buildDetailedTable(monthlyData),
        ],
      ),
    );
  }

  Widget _buildLiquidityChart(List<_LiquidityChartData> monthlyData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Коэффициенты ликвидности',
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
                    name: 'Текущая ликвидность',
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                  LineSeries<_LiquidityChartData, String>(
                    dataSource: monthlyData.reversed.toList(),
                    xValueMapper: (_LiquidityChartData data, _) => data.period,
                    yValueMapper: (_LiquidityChartData data, _) => data.quickRatio,
                    name: 'Быстрая ликвидность',
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

  Widget _buildKeyMetrics(EconomicIndicators indicators) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            'Тек. ликв.',
            indicators.liquidityRatio.toStringAsFixed(2),
            indicators.liquidityRatio > 2 ? Colors.green : Colors.orange,
            'Коэффициент текущей ликвидности',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            'Быстр. ликв.',
            indicators.quickRatio.toStringAsFixed(2),
            indicators.quickRatio > 1 ? Colors.green : Colors.orange,
            'Коэффициент быстрой ликвидности',
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

  Widget _buildDetailedTable(List<_LiquidityChartData> monthlyData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Детальная статистика ликвидности',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Период')),
                  DataColumn(label: Text('Тек. ликв.')),
                  DataColumn(label: Text('Быстр. ликв.')),
                  DataColumn(label: Text('Денежные средства')),
                  DataColumn(label: Text('Тек. активы')),
                  DataColumn(label: Text('Кратк. обяз.')),
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