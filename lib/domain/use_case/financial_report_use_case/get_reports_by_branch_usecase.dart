import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/domain/repository/financial_report_repository.dart';

class GetReportsByBranchUseCase {
  final FinancialReportRepository financialReportRepository;

  GetReportsByBranchUseCase({required this.financialReportRepository});

  Future<List<FinancialReportEntity>?> call(String branchId)async{
    try {
      return financialReportRepository.getReportsByBranch(branchId);
    } catch (e) {
      print('Error: $e');
    }

  }
}