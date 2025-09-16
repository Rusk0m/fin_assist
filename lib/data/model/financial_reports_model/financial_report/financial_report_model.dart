import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_assist/core/utils/timas_temp_converter.dart';
import 'package:fin_assist/data/model/financial_reports_model/balance/balance_model.dart';
import 'package:fin_assist/data/model/financial_reports_model/cash_flow/cash_flow_model.dart';
import 'package:fin_assist/data/model/financial_reports_model/income_statement/income_statement_model.dart';
import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:json_annotation/json_annotation.dart';

part 'financial_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FinancialReportModel {
  final String reportId;
  final String branchId;
  final String period;
  final String organizationId;
  final String type;
  final String status;
  final String submittedBy;
  @TimestampConverter()
  final DateTime createdAt;
  @TimestampConverter()
  final DateTime submittedAt;
  final BalanceModel balance;
  final CashFlowModel cashFlow;
  final IncomeStatementModel incomeStatement;

  const FinancialReportModel({
    required this.reportId,
    required this.branchId,
    required this.organizationId,
    required this.period,
    required this.type,
    required this.status,
    required this.submittedBy,
    required this.createdAt,
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
    reportId: reportId,
    branchId: branchId,
    organizationId: organizationId,
    period: period,
    type: type,
    status: status,
    submittedBy: submittedBy,
    createdAt: createdAt,
    submittedAt: submittedAt,
    balance: balance.toEntity(),
    cashFlow: cashFlow.toEntity(),
    incomeStatement: incomeStatement.toEntity(),
  );
}
