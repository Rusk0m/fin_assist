import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_assist/features/financial_reports/data/model/financial_report/financial_report_model.dart';
import 'package:fin_assist/features/financial_reports/domain/repository/financial_report_repository.dart';
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
        .doc(report.id);

    await docRef.set(FinancialReportModel(
      period: report.period,
      type: report.type,
      status: report.status,
      submittedBy: report.submittedBy,
      submittedAt: report.submittedAt,
      balance: report.balance, // BalanceModel
      cashFlow: report.cashFlow, // CashFlowModel
      incomeStatement: report.incomeStatement, // IncomeStatementModel
    ).toJson());
  }

  /// Получение всех отчетов филиала
  @override
  Future<List<FinancialReportEntity>> getReportsByBranch(String branchId) async {
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

    return FinancialReportModel.fromJson(querySnapshot.docs.first.data())
        .toEntity();
  }

  /// Получение отчета по конкретному периоду
  @override
  Future<FinancialReportEntity?> getReportByPeriod(String branchId, String period) async {
    final querySnapshot = await firestore
        .collectionGroup('reports')
        .where('branchId', isEqualTo: branchId)
        .where('period', isEqualTo: period)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) return null;

    return FinancialReportModel.fromJson(querySnapshot.docs.first.data())
        .toEntity();
  }
}
