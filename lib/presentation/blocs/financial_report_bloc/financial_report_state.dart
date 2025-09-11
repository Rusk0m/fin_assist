part of 'financial_report_bloc.dart';

abstract class FinancialReportState {}

class FinancialReportInitial extends FinancialReportState {}

class FinancialReportLoading extends FinancialReportState {}

class FinancialReportLoaded extends FinancialReportState {
  final List<FinancialReportEntity> reports;
  FinancialReportLoaded(this.reports);
}

class FinancialReportSubmitted extends FinancialReportState {}

class FinancialIndicatorsLoaded extends FinancialReportState {
  final EconomicIndicators indicators;
  FinancialIndicatorsLoaded(this.indicators);
}

class FinancialReportError extends FinancialReportState {
  final String message;
  FinancialReportError(this.message);
}
