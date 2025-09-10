import 'package:fin_assist/features/financial_reports/data/model/balance/balance_model.dart';
import 'package:fin_assist/features/financial_reports/data/model/cash_flow/cash_flow_model.dart';
import 'package:fin_assist/features/financial_reports/data/model/income_statement/income_statement_model.dart';
import 'package:fin_assist/features/financial_reports/domain/entity/financial_report.dart';
import 'package:json_annotation/json_annotation.dart';

part 'financial_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FinancialReportModel {
  final String period;
  final String type;
  final String status;
  final String submittedBy;
  final DateTime submittedAt;
  final BalanceModel balance;
  final CashFlowModel cashFlow;
  final IncomeStatementModel incomeStatement;

  const FinancialReportModel({
    required this.period,
    required this.type,
    required this.status,
    required this.submittedBy,
    required this.submittedAt,
    required this.balance,
    required this.cashFlow,
    required this.incomeStatement,
  });

  factory FinancialReportModel.fromJson(Map<String, dynamic> json) =>
      _$FinancialReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$FinancialReportModelToJson(this);

  /// маппинг в domain entity
  FinancialReportEntity toEntity() => FinancialReportEntity(
    period: period,
    type: type,
    status: status,
    submittedBy: submittedBy,
    submittedAt: submittedAt,
    balance: balance.toEntity(),
    cashFlow: cashFlow.toEntity(),
    incomeStatement: incomeStatement.toEntity(),
  );
}
