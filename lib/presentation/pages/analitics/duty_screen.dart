import 'package:fin_assist/domain/entity/economic_indicators.dart';
import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/domain/services/economic_indicators_service.dart';
import 'package:fin_assist/generated/l10n.dart';
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
            S.of(context).numPeriod(period),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // График отношения долга к капиталу
          _buildDebtToEquityChart(monthlyData,context),
          const SizedBox(height: 20),

          // График структуры долга
          _buildDebtStructureChart(monthlyData,context),
          const SizedBox(height: 20),

          // Ключевые показатели
          _buildKeyMetrics(aggregatedIndicators, monthlyData,context),
          const SizedBox(height: 20),

          // Детальная таблица
          _buildDetailedTable(monthlyData,context),
        ],
      ),
    );
  }

  Widget _buildDebtToEquityChart(List<_DutyChartData> monthlyData,BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              S.of(context).debtToCapital,
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
                  title: AxisTitle(text: S.of(context).coefficient),
                ),
                series: <CartesianSeries>[
                  LineSeries<_DutyChartData, String>(
                    dataSource: monthlyData.reversed.toList(),
                    xValueMapper: (_DutyChartData data, _) => data.period,
                    yValueMapper: (_DutyChartData data, _) => data.debtToEquity,
                    name: S.of(context).debtCapital,
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                ],
                tooltipBehavior: TooltipBehavior(enable: true),
              ),
            ),
            const SizedBox(height: 10),
            _buildDebtInterpretation(monthlyData.last.debtToEquity,context),
          ],
        ),
      ),
    );
  }

  Widget _buildDebtStructureChart(List<_DutyChartData> monthlyData, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).structureOfLiabilities,
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
                    name: S.of(context).shortTerm,
                    color: Colors.orange,
                  ),
                  ColumnSeries<_DutyChartData, String>(
                    dataSource: monthlyData.reversed.toList(),
                    xValueMapper: (_DutyChartData data, _) => data.period,
                    yValueMapper: (_DutyChartData data, _) => data.longTermDebt,
                    name: S.of(context).longTerm,
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

  Widget _buildKeyMetrics(EconomicIndicators indicators, List<_DutyChartData> monthlyData,BuildContext context) {
    final currentData = monthlyData.isNotEmpty ? monthlyData.last : _DutyChartData.empty();
    final totalDebt = currentData.shortTermDebt + currentData.longTermDebt;

    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            S.of(context).debitCapital,
            indicators.debtToEquity.toStringAsFixed(2),
            _getDebtToEquityColor(indicators.debtToEquity),
            S.of(context).debtToEquityRatio,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            S.of(context).totalDebt,
            '${totalDebt.toStringAsFixed(0)}',
            Colors.grey,
            S.of(context).totalLiabilities,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            S.of(context).debtAssets,
            currentData.debtRatio.toStringAsFixed(2),
            _getDebtRatioColor(currentData.debtRatio),
            S.of(context).debtToAssetsRatio,
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

  Widget _buildDebtInterpretation(double debtToEquity,BuildContext context) {
    String interpretation;
    Color color;

    if (debtToEquity < 0.5) {
      interpretation = S.of(context).lowDebtBurden;
      color = Colors.green;
    } else if (debtToEquity < 1.0) {
      interpretation = S.of(context).moderateDebtBurden;
      color = Colors.orange;
    } else if (debtToEquity < 2.0) {
      interpretation = S.of(context).highDebtBurden;
      color = Colors.orange;
    } else {
      interpretation = S.of(context).veryHighDebtBurden;
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

  Widget _buildDetailedTable(List<_DutyChartData> monthlyData,BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).detailedDebtStatistics,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text(S.of(context).period)),
                  DataColumn(label: Text(S.of(context).debtCap)),
                  DataColumn(label: Text(S.of(context).brieflyMust)),
                  DataColumn(label: Text(S.of(context).debtMust)),
                  DataColumn(label: Text(S.of(context).totalDebt)),
                  DataColumn(label: Text(S.of(context).capital)),
                  DataColumn(label: Text(S.of(context).debtAssets)),
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