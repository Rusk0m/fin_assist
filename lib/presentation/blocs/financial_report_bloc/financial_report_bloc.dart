import 'package:bloc/bloc.dart';
import 'package:fin_assist/di.dart';
import 'package:fin_assist/domain/entity/economic_indicators.dart';
import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/domain/use_case/financial_report_use_case/get_economic_Indicators_for_branch_usecase.dart';
import 'package:fin_assist/domain/use_case/financial_report_use_case/get_reports_by_branch_usecase.dart';
import 'package:fin_assist/domain/use_case/financial_report_use_case/submit_report_usecase.dart';

part 'financial_report_event.dart';
part 'financial_report_state.dart';

class FinancialReportBloc extends Bloc<FinancialReportEvent, FinancialReportState> {

  FinancialReportBloc() : super(FinancialReportInitial()) {
    on<LoadBranchReports>(_onLoadReports);
    on<SubmitReport>(_onSubmitReport);
    on<CalculateIndicators>(_onCalculateIndicators);
  }

  Future<void> _onLoadReports(
      LoadBranchReports event,
      Emitter<FinancialReportState> emit,
      ) async {
    emit(FinancialReportLoading());
    try {
      final reports = await getIt<GetReportsByBranchUseCase>().call(event.branchId);
      emit(FinancialReportLoaded(reports!));
    } catch (e) {
      emit(FinancialReportError(e.toString()));
    }
  }

  Future<void> _onSubmitReport(
      SubmitReport event,
      Emitter<FinancialReportState> emit,
      ) async {
    emit(FinancialReportLoading());
    try {
      await getIt<SubmitReportUseCase>().call(event.report);
      emit(FinancialReportSubmitted());
    } catch (e) {
      emit(FinancialReportError(e.toString()));
    }
  }

  Future<void> _onCalculateIndicators(
      CalculateIndicators event,
      Emitter<FinancialReportState> emit,
      ) async {
    emit(FinancialReportLoading());
    try {
      final indicators = await getIt<GetEconomicIndicatorsForBranchUseCase>().call(event.branchId);
      emit(FinancialIndicatorsLoaded(indicators!));
    } catch (e) {
      emit(FinancialReportError(e.toString()));
    }
  }
}
