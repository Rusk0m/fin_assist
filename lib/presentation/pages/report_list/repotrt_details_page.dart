// detail_report_page.dart
import 'package:fin_assist/domain/services/report_pdf_exporter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fin_assist/domain/entity/financial_report.dart'; // скорректируй путь, если нужно

class DetailReportPage extends StatelessWidget {
  final FinancialReportEntity report;

  const DetailReportPage({Key? key, required this.report}) : super(key: key);

  String _formatDate(DateTime? d) {
    if (d == null) return '-';
    return DateFormat('dd.MM.yyyy HH:mm').format(d);
  }

  String _formatNumber(num? v) {
    if (v == null) return '-';
    final formatter =
        NumberFormat.decimalPattern(); // локализованное форматирование
    return formatter.format(v);
  }

  Widget _buildKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(key, style: const TextStyle(fontWeight: FontWeight.w600)),
          Flexible(child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // safety: многие поля могут быть nullable в entity — учитываем это
    final balance = report.balance;
    final cashFlow = report.cashFlow;
    final income = report.incomeStatement;

    return Scaffold(
      appBar: AppBar(title: Text('Отчёт — ${report.period ?? '-'}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Блок метаданных отчёта ---
            _sectionTitle('Общая информация'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    // reportId — уникальный id отчёта
                    _buildKeyValue('Report ID', report.reportId ?? '-'),
                    // document id / firestore id (если есть)
                    // Если у тебя есть отдельное поле __id__, можно вывести его
                    // _buildKeyValue('__id__', report.docId ?? '-'),
                    _buildKeyValue(
                      'Organization ID',
                      report.organizationId ?? '-',
                    ),
                    _buildKeyValue('Branch ID', report.branchId ?? '-'),
                    _buildKeyValue('Period', report.period ?? '-'),
                    _buildKeyValue('Type', report.type ?? '-'),
                    // monthly/quarterly и т.д.
                    _buildKeyValue('Status', report.status ?? '-'),
                    // submitted/draft
                    _buildKeyValue(
                      'Submitted by (uid)',
                      report.submittedBy ?? '-',
                    ),
                    _buildKeyValue('Created at', _formatDate(report.createdAt)),
                    _buildKeyValue(
                      'Submitted at',
                      _formatDate(report.submittedAt),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // --- Баланс (Balance) ---
            _sectionTitle('Баланс'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: balance == null
                    ? const Text('Данные баланса отсутствуют')
                    : Column(
                        children: [
                          _buildKeyValue(
                            'Наличность (cash)',
                            _formatNumber(balance.cash),
                          ),
                          _buildKeyValue(
                            'Оборотные активы (currentAssets)',
                            _formatNumber(balance.currentAssets),
                          ),
                          _buildKeyValue(
                            'Внеоборотные активы (nonCurrentAssets)',
                            _formatNumber(balance.nonCurrentAssets),
                          ),
                          _buildKeyValue(
                            'Дебиторская задолженность (receivables)',
                            _formatNumber(balance.receivables),
                          ),
                          _buildKeyValue(
                            'Запасы (inventory)',
                            _formatNumber(balance.inventory),
                          ),
                          _buildKeyValue(
                            'Краткосрочные обязательства (shortTermLiabilities)',
                            _formatNumber(balance.shortTermLiabilities),
                          ),
                          _buildKeyValue(
                            'Долгосрочные обязательства (longTermLiabilities)',
                            _formatNumber(balance.longTermLiabilities),
                          ),
                          _buildKeyValue(
                            'Собственный капитал (equity)',
                            _formatNumber(balance.equity),
                          ),
                          _buildKeyValue(
                            'Всего активов (totalAssets)',
                            _formatNumber(balance.totalAssets),
                          ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 12),

            // --- Отчёт о движении денежных средств (Cash Flow) ---
            _sectionTitle('Движение денежных средств'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: cashFlow == null
                    ? const Text('Данные cash flow отсутствуют')
                    : Column(
                        children: [
                          _buildKeyValue(
                            'Операционная деятельность (operating)',
                            _formatNumber(cashFlow.operating),
                          ),
                          _buildKeyValue(
                            'Инвестиционная деятельность (investing)',
                            _formatNumber(cashFlow.investing),
                          ),
                          _buildKeyValue(
                            'Финансовая деятельность (financing)',
                            _formatNumber(cashFlow.financing),
                          ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 12),

            // --- Отчёт о прибылях и убытках (Income Statement) ---
            _sectionTitle('Отчёт о прибылях и убытках'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: income == null
                    ? const Text('Данные income statement отсутствуют')
                    : Column(
                        children: [
                          _buildKeyValue(
                            'Выручка (revenue)',
                            _formatNumber(income.revenue),
                          ),
                          _buildKeyValue(
                            'Себестоимость продаж (cogs)',
                            _formatNumber(income.cogs),
                          ),
                          _buildKeyValue(
                            'Чистая прибыль (netProfit)',
                            _formatNumber(income.netProfit),
                          ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 24),

            // Опциональные данные / действия
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // пример: открыть страницу для редактирования / экспортировать
                    // Navigator.pushNamed(context, '/edit_report', arguments: report);
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Редактировать'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () async {
                    final file = await ReportPdfExporter.exportReport(report);
                   /* if (file != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("PDF сохранён: ${file.path}")),
                      );
                    }*/
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Экспорт'),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
