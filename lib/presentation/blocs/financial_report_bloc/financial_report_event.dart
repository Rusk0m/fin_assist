part of 'financial_report_bloc.dart';

abstract class FinancialReportEvent extends Equatable {
  const FinancialReportEvent();

  @override
  List<Object> get props => [];
}

class GetLatestReportEvent extends FinancialReportEvent {
  final String branchId;

  const GetLatestReportEvent(this.branchId);

  @override
  List<Object> get props => [branchId];
}

class GetReportByPeriodEvent extends FinancialReportEvent {
  final String branchId;
  final String period;

  const GetReportByPeriodEvent({
    required this.branchId,
    required this.period,
  });

  @override
  List<Object> get props => [branchId, period];
}

class GetReportsByBranchEvent extends FinancialReportEvent {
  final String branchId;

  const GetReportsByBranchEvent(this.branchId);

  @override
  List<Object> get props => [branchId];
}

class SubmitReportEvent extends FinancialReportEvent {
  final FinancialReportEntity report;

  const SubmitReportEvent(this.report);

  @override
  List<Object> get props => [report];
}

class ResetReportStateEvent extends FinancialReportEvent {}