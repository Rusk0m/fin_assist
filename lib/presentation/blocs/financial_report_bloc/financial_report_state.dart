part of 'financial_report_bloc.dart';

abstract class FinancialReportState extends Equatable {
  const FinancialReportState();

  @override
  List<Object> get props => [];
}

class FinancialReportInitial extends FinancialReportState {}

class FinancialReportLoading extends FinancialReportState {}

class FinancialReportLoadedState extends FinancialReportState {
  final FinancialReportEntity report;

  const FinancialReportLoadedState(this.report);

  @override
  List<Object> get props => [report];
}

class FinancialReportsLoadedState extends FinancialReportState {
  final List<FinancialReportEntity> reports;

  const FinancialReportsLoadedState(this.reports);

  @override
  List<Object> get props => [reports];
}

class FinancialReportNotFoundState extends FinancialReportState {}

class FinancialReportSubmittedState extends FinancialReportState {
  final FinancialReportEntity report;

  const FinancialReportSubmittedState(this.report);

  @override
  List<Object> get props => [report];
}

class FinancialReportErrorState extends FinancialReportState {
  final String message;

  const FinancialReportErrorState(this.message);

  @override
  List<Object> get props => [message];
}