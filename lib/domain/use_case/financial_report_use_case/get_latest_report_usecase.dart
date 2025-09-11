import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/domain/repository/financial_report_repository.dart';

class GetLatestReportUseCase {
  final FinancialReportRepository financialReportRepository;

  GetLatestReportUseCase({required this.financialReportRepository});

  Future<FinancialReportEntity?> call (String branchId) async {
    try {
      return  financialReportRepository.getLatestReport(branchId);
    } catch (e) {
      print('Error: $e');
    }
  }
}