import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/domain/repository/financial_report_repository.dart';

class GetReportByPeriodUseCase {
  final FinancialReportRepository financialReportRepository;

  GetReportByPeriodUseCase({required this.financialReportRepository});

  Future<FinancialReportEntity?> call(PeriodParams params) async {
    try {
      return financialReportRepository.getReportByPeriod(
        params.branchId,
        params.period,
      );
    } catch (e) {
      print('Error: $e');
    }
  }
}

class PeriodParams {
  final String branchId;
  final String period;

  PeriodParams({required this.branchId, required this.period});
}
