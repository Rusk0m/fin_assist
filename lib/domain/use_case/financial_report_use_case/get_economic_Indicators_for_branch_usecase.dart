import 'package:fin_assist/domain/entity/economic_indicators.dart';
import 'package:fin_assist/domain/repository/financial_report_repository.dart';
import 'package:fin_assist/domain/services/economic_indicators_service.dart';

class GetEconomicIndicatorsForBranchUseCase {
  final EconomicIndicatorsService service;
  final FinancialReportRepository repository;

  GetEconomicIndicatorsForBranchUseCase({required this.service, required this.repository});

  //Получает агрегировыанные данные
  Future<EconomicIndicators?> call(String branchId) async{
    try {
      final report = await repository.getReportsByBranch(branchId);
      return service.calculateAggregatedIndicators(report);
    } catch (e) {
      print('Error: $e');

    }
  }
}