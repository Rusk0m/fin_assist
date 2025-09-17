import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_assist/di.dart';
import 'package:fin_assist/domain/use_case/financial_report_use_case/get_latest_report_usecase.dart';
import 'package:fin_assist/domain/use_case/financial_report_use_case/get_report_by_period_usecase.dart';
import 'package:fin_assist/domain/use_case/financial_report_use_case/get_reports_by_branch_usecase.dart';
import 'package:fin_assist/domain/use_case/financial_report_use_case/submit_report_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:fin_assist/domain/entity/financial_report.dart';

part 'financial_report_event.dart';
part 'financial_report_state.dart';

class FinancialReportBloc extends Bloc<FinancialReportEvent, FinancialReportState> {
  FinancialReportBloc() : super(FinancialReportInitial()) {
    on<GetLatestReportEvent>(_onGetLatestReport);
    on<GetReportByPeriodEvent>(_onGetReportByPeriod);
    on<GetReportsByBranchEvent>(_onGetReportsByBranch);
    on<SubmitReportEvent>(_onSubmitReport);
    on<ResetReportStateEvent>(_onResetReportState);
  }

  Future<void> _onGetLatestReport(
      GetLatestReportEvent event,
      Emitter<FinancialReportState> emit,
      ) async {
    emit(FinancialReportLoading());
    try {
      final report = await GetIt.instance<GetLatestReportUseCase>().call(event.branchId);

      if (report != null) {
        emit(FinancialReportLoadedState(report));
      } else {
        emit(FinancialReportNotFoundState());
      }
    } catch (e) {
      print('FinancialReportBloc: Error loading latest report: $e');
      emit(FinancialReportErrorState('Ошибка загрузки отчета: ${e.toString()}'));
    }
  }

  Future<void> _onGetReportByPeriod(
      GetReportByPeriodEvent event,
      Emitter<FinancialReportState> emit,
      ) async {
    emit(FinancialReportLoading());
    try {
      final report = await GetIt.instance<GetReportByPeriodUseCase>().call(
        PeriodParams(branchId: event.branchId, period: event.period),
      );

      if (report != null) {
        emit(FinancialReportLoadedState(report));
      } else {
        emit(FinancialReportNotFoundState());
      }
    } catch (e) {
      print('FinancialReportBloc: Error loading report by period: $e');
      emit(FinancialReportErrorState('Ошибка загрузки отчета за период: ${e.toString()}'));
    }
  }

  Future<void> _onGetReportsByBranch(
      GetReportsByBranchEvent event,
      Emitter<FinancialReportState> emit,
      ) async {
    print("📌 FinancialReportBloc получил branchId: ${event.branchId}");
    emit(FinancialReportLoading());
    try {
      final reports = await getIt<GetReportsByBranchUseCase>().call(event.branchId);
      print(reports);
      emit(FinancialReportsLoadedState(reports!));
    } catch (e) {
      print('FinancialReportBloc: Error loading reports by branch: $e');
      emit(FinancialReportErrorState('Ошибка загрузки отчетов филиала: ${e.toString()}'));
    }
  }

  Future<void> _onSubmitReport(
      SubmitReportEvent event,
      Emitter<FinancialReportState> emit,
      ) async {
    emit(FinancialReportLoading());
    try {
      await GetIt.instance<SubmitReportUseCase>().call(event.report);
      emit(FinancialReportSubmittedState(event.report));
    } catch (e) {
      print('FinancialReportBloc: Error submitting report: $e');
      emit(FinancialReportErrorState('Ошибка отправки отчета: ${e.toString()}'));
    }
  }

  void _onResetReportState(
      ResetReportStateEvent event,
      Emitter<FinancialReportState> emit,
      ) {
    emit(FinancialReportInitial());
  }
}