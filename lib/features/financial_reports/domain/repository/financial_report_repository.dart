import '../entity/financial_report.dart';

abstract class FinancialReportRepository {
  /// Получить все отчёты по филиалу
  Future<List<FinancialReportEntity>> getReportsByBranch(String branchId);

  /// Получить последний отчёт по филиалу (по дате)
  Future<FinancialReportEntity?> getLatestReport(String branchId);

  /// Добавить/отправить новый отчёт
  Future<void> submitReport(FinancialReportEntity report);

  /// Получить отчёт по конкретному периоду
  Future<FinancialReportEntity?> getReportByPeriod(String branchId, String period);
}
