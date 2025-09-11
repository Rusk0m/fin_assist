import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_assist/data/model/financial_reports_model/balance/balance_model.dart';
import 'package:fin_assist/data/model/financial_reports_model/cash_flow/cash_flow_model.dart';
import 'package:fin_assist/data/model/financial_reports_model/financial_report/financial_report_model.dart';
import 'package:fin_assist/data/model/financial_reports_model/income_statement/income_statement_model.dart';
import 'package:fin_assist/domain/repository/financial_report_repository.dart';
import '../../domain/entity/financial_report.dart';

class FinancialReportRepositoryImpl implements FinancialReportRepository {
  final FirebaseFirestore firestore;

  FinancialReportRepositoryImpl(this.firestore);

  /// Добавление нового отчета
  @override
  Future<void> submitReport(FinancialReportEntity report) async {
    final docRef = firestore
        .collection('branches')
        .doc(report.branchId)
        .collection('reports')
        .doc(report.reportId);

    await docRef.set(
      FinancialReportModel(
        reportId: report.reportId,
        branchId: report.branchId,
        organizationId: report.organizationId,
        period: report.period,
        type: report.type,
        status: report.status,
        submittedBy: report.submittedBy,
        submittedAt: report.submittedAt,
        balance: BalanceModel.fromEntity(report.balance), // BalanceModel
        cashFlow: CashFlowModel.fromEntity(report.cashFlow), // CashFlowModel
        incomeStatement: IncomeStatementModel.fromEntity(report.incomeStatement), // IncomeStatementModel
      ).toJson(),
    );
  }

  /// Получение всех отчетов филиала
  @override
  Future<List<FinancialReportEntity>> getReportsByBranch(String branchId,) async {
    final querySnapshot = await firestore
        .collectionGroup('reports')
        .where('branchId', isEqualTo: branchId)
        .orderBy('submittedAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => FinancialReportModel.fromJson(doc.data()).toEntity())
        .toList();
  }

  /// Получение последнего отчета
  @override
  Future<FinancialReportEntity?> getLatestReport(String branchId) async {
    final querySnapshot = await firestore
        .collectionGroup('reports')
        .where('branchId', isEqualTo: branchId)
        .orderBy('submittedAt', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) return null;

    return FinancialReportModel.fromJson(
      querySnapshot.docs.first.data(),
    ).toEntity();
  }

  /// Получение отчета по конкретному периоду
  @override
  Future<FinancialReportEntity?> getReportByPeriod(
    String branchId,
    String period,
  ) async {
    final querySnapshot = await firestore
        .collectionGroup('reports')
        .where('branchId', isEqualTo: branchId)
        .where('period', isEqualTo: period)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) return null;

    return FinancialReportModel.fromJson(
      querySnapshot.docs.first.data(),
    ).toEntity();
  }
}
