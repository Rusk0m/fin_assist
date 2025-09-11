part of'financial_report_bloc.dart';

abstract class FinancialReportEvent {}

class LoadBranchReports extends FinancialReportEvent {
  final String branchId;
  LoadBranchReports(this.branchId);
}

class SubmitReport extends FinancialReportEvent {
  final FinancialReportEntity report;
  SubmitReport(this.report);
}

class CalculateIndicators extends FinancialReportEvent {
  final String branchId;
  CalculateIndicators(this.branchId);
}
