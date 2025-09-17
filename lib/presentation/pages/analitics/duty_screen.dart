import 'package:fin_assist/domain/entity/economic_indicators.dart';
import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/domain/services/economic_indicators_service.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DutyScreen extends StatelessWidget {
  final List<FinancialReportEntity> reports;
  final int period;

  const DutyScreen({super.key, required this.reports, required this.period});

  @override
  Widget build(BuildContext context) {
    final indicatorsService = EconomicIndicatorsService();
    final monthlyData = reports.map((report) {
      final indicators = indicatorsService.calculateIndicators(report);
      return _DutyChartData(
        period: report.period,
        debtToEquity: indicators.debtToEquity,
        shortTermDebt: report.balance.shortTermLiabilities,
        longTermDebt: report.balance.longTermLiabilities,
        totalDebt: report.balance.shortTermLiabilities + report.balance.longTermLiabilities,
        equity: report.balance.equity,
        debtRatio: (report.balance.shortTermLiabilities + report.balance.longTermLiabilities) /
            report.balance.totalAssets,
      );
    }).toList();

    final aggregatedIndicators = indicatorsService.calculateAggregatedIndicators(reports);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Анализ задолженности ($period месяцев)',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // График отношения долга к капиталу
          _buildDebtToEquityChart(monthlyData),
          const SizedBox(height: 20),

          // График структуры долга
          _buildDebtStructureChart(monthlyData),
          const SizedBox(height: 20),

          // Ключевые показатели
          _buildKeyMetrics(aggregatedIndicators, monthlyData),
          const SizedBox(height: 20),

          // Детальная таблица
          _buildDetailedTable(monthlyData),
        ],
      ),
    );
  }

  Widget _buildDebtToEquityChart(List<_DutyChartData> monthlyData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Отношение долга к собственному капиталу',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  labelRotation: -45,
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'Коэффициент'),
                ),
                series: <CartesianSeries>[
                  LineSeries<_DutyChartData, String>(
                    dataSource: monthlyData.reversed.toList(),
                    xValueMapper: (_DutyChartData data, _) => data.period,
                    yValueMapper: (_DutyChartData data, _) => data.debtToEquity,
                    name: 'Долг/Капитал',
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                ],
                tooltipBehavior: TooltipBehavior(enable: true),
              ),
            ),
            const SizedBox(height: 10),
            _buildDebtInterpretation(monthlyData.last.debtToEquity),
          ],
        ),
      ),
    );
  }

  Widget _buildDebtStructureChart(List<_DutyChartData> monthlyData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Структура обязательств',
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
                  ColumnSeries<_DutyChartData, String>(
                    dataSource: monthlyData.reversed.toList(),
                    xValueMapper: (_DutyChartData data, _) => data.period,
                    yValueMapper: (_DutyChartData data, _) => data.shortTermDebt,
                    name: 'Краткосрочные',
                    color: Colors.orange,
                  ),
                  ColumnSeries<_DutyChartData, String>(
                    dataSource: monthlyData.reversed.toList(),
                    xValueMapper: (_DutyChartData data, _) => data.period,
                    yValueMapper: (_DutyChartData data, _) => data.longTermDebt,
                    name: 'Долгосрочные',
                    color: Colors.blue,
                  ),
                ],
                legend: const Legend(isVisible: true),
               // isStacked: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetrics(EconomicIndicators indicators, List<_DutyChartData> monthlyData) {
    final currentData = monthlyData.isNotEmpty ? monthlyData.last : _DutyChartData.empty();
    final totalDebt = currentData.shortTermDebt + currentData.longTermDebt;

    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            'Долг/Кап.',
            indicators.debtToEquity.toStringAsFixed(2),
            _getDebtToEquityColor(indicators.debtToEquity),
            'Отношение долга к капиталу',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            'Общий долг',
            '${totalDebt.toStringAsFixed(0)}',
            Colors.grey,
            'Всего обязательств',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            'Долг/Активы',
            currentData.debtRatio.toStringAsFixed(2),
            _getDebtRatioColor(currentData.debtRatio),
            'Доля долга в активах',
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
                fontSize: 18,
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

  Widget _buildDebtInterpretation(double debtToEquity) {
    String interpretation;
    Color color;

    if (debtToEquity < 0.5) {
      interpretation = 'Низкая долговая нагрузка ✓';
      color = Colors.green;
    } else if (debtToEquity < 1.0) {
      interpretation = 'Умеренная долговая нагрузка';
      color = Colors.orange;
    } else if (debtToEquity < 2.0) {
      interpretation = 'Высокая долговая нагрузка ⚠️';
      color = Colors.orange;
    } else {
      interpretation = 'Очень высокая долговая нагрузка ❗';
      color = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        interpretation,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDetailedTable(List<_DutyChartData> monthlyData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Детальная статистика задолженности',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Период')),
                  DataColumn(label: Text('Долг/Кап.')),
                  DataColumn(label: Text('Кратк. обяз.')),
                  DataColumn(label: Text('Долг. обяз.')),
                  DataColumn(label: Text('Всего долг')),
                  DataColumn(label: Text('Капитал')),
                  DataColumn(label: Text('Долг/Активы')),
                ],
                rows: monthlyData.reversed.map((data) {
                  return DataRow(cells: [
                    DataCell(Text(data.period)),
                    DataCell(Text(data.debtToEquity.toStringAsFixed(2))),
                    DataCell(Text(data.shortTermDebt.toStringAsFixed(0))),
                    DataCell(Text(data.longTermDebt.toStringAsFixed(0))),
                    DataCell(Text(data.totalDebt.toStringAsFixed(0))),
                    DataCell(Text(data.equity.toStringAsFixed(0))),
                    DataCell(Text(data.debtRatio.toStringAsFixed(2))),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDebtToEquityColor(double ratio) {
    if (ratio < 0.5) return Colors.green;
    if (ratio < 1.0) return Colors.orange;
    if (ratio < 2.0) return Colors.orange;
    return Colors.red;
  }

  Color _getDebtRatioColor(double ratio) {
    if (ratio < 0.3) return Colors.green;
    if (ratio < 0.6) return Colors.orange;
    return Colors.red;
  }
}

class _DutyChartData {
  final String period;
  final double debtToEquity;
  final double shortTermDebt;
  final double longTermDebt;
  final double totalDebt;
  final double equity;
  final double debtRatio;

  _DutyChartData({
    required this.period,
    required this.debtToEquity,
    required this.shortTermDebt,
    required this.longTermDebt,
    required this.totalDebt,
    required this.equity,
    required this.debtRatio,
  });

  factory _DutyChartData.empty() {
    return _DutyChartData(
      period: '',
      debtToEquity: 0,
      shortTermDebt: 0,
      longTermDebt: 0,
      totalDebt: 0,
      equity: 0,
      debtRatio: 0,
    );
  }
}