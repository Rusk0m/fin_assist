import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/domain/repository/financial_report_repository.dart';

class SubmitReportUseCase {
  final FinancialReportRepository financialReportRepository;

  SubmitReportUseCase({required this.financialReportRepository});

  Future<void> call(FinancialReportEntity report)async{
    try {
      financialReportRepository.submitReport(report);
    } catch (e) {
      print('Error: $e');
    }
  }
}