import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:fin_assist/domain/entity/financial_report.dart';

class ReportPdfExporter {
  /// Экспортирует финансовый отчёт в PDF с шрифтом Times New Roman и уменьшенным размером шрифта.
  static Future<void> exportReport(FinancialReportEntity report) async {
    final pdf = pw.Document();
    final dateFormatter = DateFormat('dd.MM.yyyy');
    final numberFormatter = NumberFormat("#,##0.00", "ru_RU");

    // ---------- Загружаем шрифт Times New Roman ----------
    final fontData = await rootBundle.load('lib/assets/fonts/times_new_roman.ttf');
    final ttf = pw.Font.ttf(fontData);

    // ---------- Добавляем страницу ----------
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          // ---------- Заголовок ----------
          pw.Header(
            level: 0,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  "ОТЧЁТ ФИНАНСОВЫЙ",
                  style: pw.TextStyle(font: ttf, fontSize: 14, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  "за период: ${report.period ?? '-'}",
                  style: pw.TextStyle(font: ttf, fontSize: 10),
                ),
              ],
            ),
          ),

          // ---------- Общая информация ----------
          pw.Text(
            "Общая информация",
            style: pw.TextStyle(font: ttf, fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          pw.Table.fromTextArray(
            cellStyle: pw.TextStyle(font: ttf, fontSize: 9),
            headerStyle: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold, fontSize: 9),
            headers: ["Поле", "Значение"],
            data: [
              ["ID отчёта", report.reportId ?? "-"],
              ["Организация", report.organizationId ?? "-"],
              ["Филиал", report.branchId ?? "-"],
              ["Тип", report.type ?? "-"],
              ["Статус", report.status ?? "-"],
              [
                "Создан",
                report.createdAt != null ? dateFormatter.format(report.createdAt!) : "-"
              ],
              [
                "Отправлен",
                report.submittedAt != null ? dateFormatter.format(report.submittedAt!) : "-"
              ],
            ],
          ),

          pw.SizedBox(height: 20),

          // ---------- Бухгалтерский баланс ----------
          pw.Text(
            "Бухгалтерский баланс",
            style: pw.TextStyle(font: ttf, fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          pw.Table.fromTextArray(
            headers: ["Показатель", "Значение"],
            headerStyle: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold, fontSize: 9),
            cellStyle: pw.TextStyle(font: ttf, fontSize: 9),
            data: [
              ["Наличность", numberFormatter.format(report.balance?.cash ?? 0)],
              ["Оборотные активы", numberFormatter.format(report.balance?.currentAssets ?? 0)],
              ["Внеоборотные активы", numberFormatter.format(report.balance?.nonCurrentAssets ?? 0)],
              ["Дебиторская задолженность", numberFormatter.format(report.balance?.receivables ?? 0)],
              ["Запасы", numberFormatter.format(report.balance?.inventory ?? 0)],
              ["Краткосрочные обязательства", numberFormatter.format(report.balance?.shortTermLiabilities ?? 0)],
              ["Долгосрочные обязательства", numberFormatter.format(report.balance?.longTermLiabilities ?? 0)],
              ["Собственный капитал", numberFormatter.format(report.balance?.equity ?? 0)],
              ["Итого активов", numberFormatter.format(report.balance?.totalAssets ?? 0)],
            ],
          ),

          pw.SizedBox(height: 20),

          // ---------- Движение денежных средств ----------
          pw.Text(
            "Отчёт о движении денежных средств",
            style: pw.TextStyle(font: ttf, fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          pw.Table.fromTextArray(
            headers: ["Статья", "Значение"],
            headerStyle: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold, fontSize: 9),
            cellStyle: pw.TextStyle(font: ttf, fontSize: 9),
            data: [
              ["Операционная деятельность", numberFormatter.format(report.cashFlow?.operating ?? 0)],
              ["Инвестиционная деятельность", numberFormatter.format(report.cashFlow?.investing ?? 0)],
              ["Финансовая деятельность", numberFormatter.format(report.cashFlow?.financing ?? 0)],
            ],
          ),

          pw.SizedBox(height: 20),

          // ---------- Отчёт о прибылях и убытках ----------
          pw.Text(
            "Отчёт о прибылях и убытках",
            style: pw.TextStyle(font: ttf, fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          pw.Table.fromTextArray(
            headers: ["Статья", "Значение"],
            headerStyle: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold, fontSize: 9),
            cellStyle: pw.TextStyle(font: ttf, fontSize: 9),
            data: [
              ["Выручка", numberFormatter.format(report.incomeStatement?.revenue ?? 0)],
              ["Себестоимость продаж", numberFormatter.format(report.incomeStatement?.cogs ?? 0)],
              ["Чистая прибыль", numberFormatter.format(report.incomeStatement?.netProfit ?? 0)],
            ],
          ),

          pw.SizedBox(height: 30),

          // ---------- Подписи ----------
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                children: [
                  pw.Text("Руководитель", style: pw.TextStyle(font: ttf, fontSize: 10)),
                  pw.SizedBox(height: 30),
                  pw.Text("_____________ /ФИО/", style: pw.TextStyle(font: ttf, fontSize: 10)),
                ],
              ),
              pw.Column(
                children: [
                  pw.Text("Бухгалтер", style: pw.TextStyle(font: ttf, fontSize: 10)),
                  pw.SizedBox(height: 30),
                  pw.Text("_____________ /ФИО/", style: pw.TextStyle(font: ttf, fontSize: 10)),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    try {
      final pdfBytes = await pdf.save();
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/report_${report.reportId}.pdf');
      await file.writeAsBytes(pdfBytes);

      print("✅ PDF сохранён: ${file.path}");
      await OpenFilex.open(file.path);
    } catch (e) {
      print("⚠ Ошибка при сохранении PDF: $e");
    }
  }
}
